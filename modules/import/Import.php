<?php
/*
 * CATS
 * Import Library
 *
 * Copyright (C) 2005 - 2007 Cognizo Technologies, Inc.
 *
 *
 * The contents of this file are subject to the CATS Public License
 * Version 1.1a (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.catsone.com/.
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Original Code is "CATS Standard Edition".
 *
 * The Initial Developer of the Original Code is Cognizo Technologies, Inc.
 * Portions created by the Initial Developer are Copyright (C) 2005 - 2007
 * (or from the year in which this file was created to the year 2007) by
 * Cognizo Technologies, Inc. All Rights Reserved.
 *
 *
 * $Id: Import.php 3785 2007-12-03 21:59:23Z brian $
 */

class Import
{
    private $_db;
    private $_siteID;


    public function __construct($siteID)
    {
        $this->_siteID = $siteID;
        $this->_db = DatabaseConnection::getInstance();
    }


    /**
     * Adds a record for an import group into the database.
     *
     * @param table import was affecting (contacts, companies, etc)
     * @return importID
     */
    public function add($table)
    {
        $sql = sprintf(
            "INSERT INTO import (
                module_name,
                reverted,
                site_id,
				date_created
            )
            VALUES (
                '%s',
                0,
                %s,
				NOW()
            )",
            $table,
            $this->_siteID
        );

        $queryResult = $this->_db->query($sql);
        if (!$queryResult)
        {
            return -1;
        }

        return $this->_db->getLastInsertID();
    }

    /**
     * Updates an import record with a HTML string containing all errors
     * generated by the import for later viewing.
     *
     * @param importID
     * @param error HTML string
     * @param number of records added by import
     * @return query response
     */
    public function updateErrors($importID, $importErrors, $addedLines)
    {
        $sql = sprintf(
            "UPDATE
                import
             SET
                import_errors = %s,
                added_lines = %s
             WHERE
                import_id = %s
             AND
                site_id = %s",
            $this->_db->makeQueryStringOrNULL($importErrors),
            $addedLines,
            $importID,
            $this->_siteID
        );

        $queryResult = $this->_db->query($sql);
        return $queryResult;
    }

    /**
     * Removes an import record from the database, preventing any import reverting.
     * Effectively finalizes an import.
     *
     * @param importID
     * @return void
     */

    public function delete($importID)
    {
        $sql = sprintf(
            "DELETE FROM
                import
             WHERE
                import_id = %s
             AND
                site_id = %s",
            $importID,
            $this->_siteID
        );
        $queryResult = $this->_db->query($sql);

        if (!$queryResult)
        {
            return false;
        }

        return true;
    }

    /**
     * Returns an import record (probably for viewing the associated errors).
     *
     * @param importID
     * @return record
     */
    public function get($importID)
    {
        $sql = sprintf(
            "SELECT
                import.module_name AS moduleName,
                import.import_id AS importID,
                import.import_errors AS importErrors
            FROM
                import
            WHERE
                import.import_id = %s
            AND
                site_id = %s",
            $importID,
            $this->_siteID
        );

        $rs = $this->_db->getAssoc($sql);
        return $rs;
    }

    /**
     * Returns all imports for a site.
     *
     * @param importID
     * @return array of records
     */
    public function getAll()
    {
        $sql = sprintf(
            "SELECT
                import.module_name AS moduleName,
                import.import_id AS importID,
                import.added_lines AS addedLines,
                import.site_id AS siteID,
                import.import_errors AS importErrors,
				DATE_FORMAT(
                    import.date_created, '%%m-%%d-%%y (%%h:%%i %%p)'
                ) AS dateCreated
            FROM
                import
            WHERE
                import.site_id = %s
			AND
				TO_DAYS(date_created) > TO_DAYS(DATE_SUB(NOW(), INTERVAL 7 DAY))",
            $this->_siteID
        );
        $rs = $this->_db->getAllAssoc($sql);

        return $rs;
    }

    /**
     * Reverts a previous import.
     *
     * @param string table name - company / contact / candidate
     * @param integer importID
     * @return void
     */
    public function revert($tableName, $importID)
    {
        $sql = sprintf(
            "DELETE FROM
                extra_field_settings
            WHERE
                import_id = %s
            AND
                site_id = %s",
            $importID,
            $this->_siteID
        );
        $this->_db->query($sql);

        $sql = sprintf(
            "DELETE FROM
                %s
            WHERE
                import_id = %s
            AND
                site_id = %s",
            $this->_db->escapeString($tableName),
            $importID,
            $this->_siteID
        );
        $this->_db->query($sql);

        $sql = sprintf(
            "DELETE FROM
                extra_field
            WHERE
                import_id = %s
             AND
                site_id = %s",
            $importID,
            $this->_siteID
        );
        $this->_db->query($sql);

        if ($tableName == 'contact')
        {
            $sql = sprintf(
                "DELETE FROM
                    company
                WHERE
                    import_id = %s
                AND
                    site_id = %s",
                $importID,
                $this->_siteID
            );

            $this->_db->query($sql);
        }
    }

    /**
     * Adds a setting to the foreign_settings table, but avoids a duplicate entry.
     *
     * @param foreign table
     * @param field name
     * @param importID
     * @return void
     */
    public function addForeignSettingUnique($type, $field, $importID)
    {
        $sql = sprintf(
           "SELECT
                extra_field_settings.field_name AS fieldName
            FROM
                extra_field_settings
            WHERE
                extra_field_settings.site_id = %s
            AND
                extra_field_settings.field_name = %s
            AND
                extra_field_settings.data_item_type = %s",
            $this->_siteID,
            $this->_db->makeQueryStringOrNULL($field),
            $type
        );
        $rs = $this->_db->getAssoc($sql);

        if (!isset($rs['fieldName']))
        {
            $sql = sprintf(
                "INSERT INTO extra_field_settings (
                    field_name,
                    site_id,
                    date_created,
                    import_id,
                    data_item_type
                 )
                 VALUES (
                    %s,
                    %s,
                    NOW(),
                    %s,
                    %s
                 )",
                 $this->_db->makeQueryStringOrNULL($field),
                 $this->_siteID,
                 $importID,
                 $type
            );

            $rs = $this->_db->query($sql);
        }
    }

    /**
     * Adds a set of records to the foreign entry table for an
     * associated record in a normal data table.
     *
     * FIXME: Parameter documentation incorrect; types must be specified after @param.
     *
     * @param string foreign table
     * @param array fields => values
     * @param integer associated index on non foreign table
     * @param integer importID
     * @return integer getLastInsertID
     */
    public function addForeign($type, $data, $assocID, $importID)
    {
        $ar = array();
        $dataS = '';

        foreach ($data AS $field => $value)
        {
            if ($value != '')
            {
                $ar[] = '(' . $assocID . ', '
                    . $this->_db->makeQueryStringOrNULL($field) . ', '
                    . $this->_db->makeQueryStringOrNULL($value) . ', '
                    .  $importID . ',' .$this->_siteID . ', ' . $type . ')';
            }
        }
        $dataS = implode(',', $ar);

        if (!empty($dataS))
        {
            $sql = sprintf(
                "INSERT INTO extra_field (
                    data_item_id,
                    field_name,
                    value,
                    import_id,
                    site_id,
                    data_item_type
                )
                VALUES %s",
                $dataS
            );

            $queryResult = $this->_db->query($sql);
            if (!$queryResult)
            {
                return -1;
            }

            return $this->_db->getLastInsertID();
        }
    }
}

class CandidatesImport
{
    private $_db;
    private $_siteID;


    public function __construct($siteID)
    {
        $this->_siteID = $siteID;
        $this->_db = DatabaseConnection::getInstance();
    }


    /**
     * Adds a record to the candidates table.
     *
     * @param array (field => value)
     * @param userID
     * @param importID
     * @return candidateID
     */
    public function add($dataNamed, $userID, $importID, $encoding)
    {
        $dataColumns = array();
        $data = array();

        foreach ($dataNamed AS $dataColumn => $d)
        {
            $dataColumns[] = $dataColumn;
            if($encoding != ""){
                $data[] = iconv($encoding, 'UTF-8', $this->_db->makeQueryStringOrNULL($d));
            } else {
                $data[] = $this->_db->makeQueryStringOrNULL($d);
            }
        }

        $sql = sprintf(
            "INSERT INTO candidate (
                %s,
                can_relocate,
                entered_by,
                owner,
                site_id,
                date_created,
                date_modified,
                import_id
            )
            VALUES (
                %s,
                %s,
                %s,
                %s,
                %s,
                NOW(),
                NOW(),
                %s
            )",
            implode(",\n", $dataColumns),
            implode(",\n", $data),
            0,
            $userID,
            $userID,
            $this->_siteID,
            $importID
        );
        $queryResult = $this->_db->query($sql);
        if (!$queryResult)
        {
            return -1;
        }

        return $this->_db->getLastInsertID();
    }

}

class CompaniesImport
{
    private $_db;
    private $_siteID;


    public function __construct($siteID)
    {
        $this->_siteID = $siteID;
        $this->_db = DatabaseConnection::getInstance();
    }


    /**
     * Returns the company ID of a company name, or -1 if the company does not exist.
     *
     * @param company name
     * @return companyID
     */
    public function companyByName($name)
    {
        $sql = sprintf(
            "SELECT
                company.company_id AS companyID,
                company.name AS name
            FROM
                company
            WHERE
                company.name = %s
            AND
                site_id = %s
            ",
            $this->_db->makeQueryStringOrNULL($name),
            $this->_siteID
        );

        $rs = $this->_db->getAssoc($sql);
        if (empty($rs))
        {
            return -1;
        }

        return $rs['companyID'];
    }

    /**
     * Adds a record to the companies table.
     *
     * @param array (field => value)
     * @param userID
     * @param importID
     * @return companyID
     */

    public function add($dataNamed, $userID, $importID, $encoding)
    {
        $dataColumns = array();
        $data = array();

        foreach ($dataNamed AS $dataColumn => $d)
        {
            $dataColumns[] = $dataColumn;
            if($encoding != ""){
                $data[] = iconv($encoding, 'UTF-8', $this->_db->makeQueryStringOrNULL($d));
            } else {
                $data[] = $this->_db->makeQueryStringOrNULL($d);
            }
        }

        $sql = sprintf(
            "INSERT INTO company (
                %s,
                entered_by,
                owner,
                site_id,
                date_created,
                date_modified,
                import_id
            )
            VALUES (
                %s,
                %s,
                %s,
                %s,
                NOW(),
                NOW(),
                %s
            )",
            implode(",\n", $dataColumns),
            implode(",\n", $data),
            $userID,
            $userID,
            $this->_siteID,
            $importID
        );
        $queryResult = $this->_db->query($sql);
        if (!$queryResult)
        {
            return -1;
        }

        return $this->_db->getLastInsertID();
    }
}

class ContactImport
{

    private $_db;
    private $_siteID;


    public function __construct($siteID)
    {
        $this->_siteID = $siteID;
        $this->_db = DatabaseConnection::getInstance();
    }


    /**
     * Returns the company ID of a company name, or -1 if the company does not exist.
     *
     * @param company name
     * @return companyID
     */
    public function companyByName($name)
    {

        $sql = sprintf(
            "SELECT
                company.company_id AS companyID,
                company.name AS name
            FROM
                company
            WHERE
                company.name = %s
            AND
                site_id = %s",
            $this->_db->makeQueryStringOrNULL($name),
            $this->_siteID
        );

        $rs = $this->_db->getAssoc($sql);
        if (empty($rs))
        {
            return -1;
        }

        return $rs['companyID'];
    }

    /**
     * Adds a record to the companies table. (For adding with an associated contact)
     *
     * @param array (field => value)
     * @param userID
     * @param importID
     * @return companyID
     */
    public function addCompany($dataNamed, $userID, $importID, $encoding)
    {
        $dataColumns = array();
        $data = array();

        foreach ($dataNamed AS $dataColumn => $d)
        {
            $dataColumns[] = $dataColumn;
            if($encoding != ""){
                $data[] = iconv($encoding, 'UTF-8', $this->_db->makeQueryStringOrNULL($d));
            } else {
                $data[] = $this->_db->makeQueryStringOrNULL($d);
            }
        }

        $sql = sprintf(
            "INSERT INTO company (
                %s,
                entered_by,
                owner,
                site_id,
                date_created,
                date_modified,
                import_id
            )
            VALUES (
                %s,
                %s,
                %s,
                %s,
                NOW(),
                NOW(),
                %s
            )",
            implode(",\n", $dataColumns),
            implode(",\n", $data),
            $userID,
            $userID,
            $this->_siteID,
            $importID
        );
        $queryResult = $this->_db->query($sql);
        if (!$queryResult)
        {
            return -1;
        }

        return $this->_db->getLastInsertID();
    }

    /**
     * Adds a record to the contacts table.
     *
     * @param array (field => value)
     * @param userID
     * @param importID
     * @return contactID
     */
    public function add($dataNamed, $userID, $importID, $encoding)
    {
        $dataColumns = array();
        $data = array();

        foreach ($dataNamed AS $dataColumn => $d)
        {
            $dataColumns[] = $dataColumn;
            if($encoding != ""){
                $data[] = iconv($encoding, 'UTF-8', $this->_db->makeQueryStringOrNULL($d));
            } else {
                $data[] = $this->_db->makeQueryStringOrNULL($d);
            }
        }

        $sql = sprintf(
            "INSERT INTO contact (
                %s,
                entered_by,
                owner,
                site_id,
                date_created,
                date_modified,
                import_id
            )
            VALUES (
                %s,
                %s,
                %s,
                %s,
                NOW(),
                NOW(),
                %s
            )",
            implode(",\n", $dataColumns),
            implode(",\n", $data),
            $userID,
            $userID,
            $this->_siteID,
            $importID
        );
        $queryResult = $this->_db->query($sql);
        if (!$queryResult)
        {
            return -1;
        }

        return $this->_db->getLastInsertID();
    }
}

?>
