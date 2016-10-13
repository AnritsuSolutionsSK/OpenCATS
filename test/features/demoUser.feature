@demo @roles
Feature: User roles
  In order to protect sensitive information from users who should not have access to them
  Different user roles should have different permissions
  
  ######## DASHBOARD(HOME) #######

  @javascript @dashboard
  Scenario Outline: Dashboard module visibility
    Given I am logged in with <userRole> user role
    And I am on "/index.php?m=home"
    Then the page should <quickSearch> contain "Quick Search"
    And the page should <quickSearch> contain "quickSearchFor"
    And the page should <quickSearch> contain "quickSearch"
    And I should <recentCalls> "My Recent Calls"
    And I should <upcomingCalls> "My Upcoming Calls"
    And I should <upcomingEvents> "My Upcoming Events"
    And I should <recentHires> "Recent Hires"
    And I should <hiringOverview> "Hiring Overview"
    And I should <importantCandidates> "Important Candidates"
    
    Examples:
     | userRole       | quickSearch | recentCalls | upcomingCalls | upcomingEvents | recentHires | hiringOverview | importantCandidates| 
     | DEMO           |             | see         | see           | see            | see         | see            | see                |
     
     
  ####### ACTIVITIES #######
    
  @javascript @activities
  Scenario Outline: Activities module visibility
    Given I am logged in with <userRole> user role
    And I am on "/index.php?m=activity"
    Then the page should <quickSearch> contain "Quick Search"
    And the page should <quickSearch> contain "quickSearchFor"
    And the page should <quickSearch> contain "quickSearch"
    And I should <timeFilter> "Today"
    And I should <timeFilter> "Yesterday"
    And I should <timeFilter> "Last Week"
    And I should <timeFilter> "Last Month"
    And I should <timeFilter> "Last 6 Months"
    And I should <timeFilter> "All"
    And I should <filter> "Filter"
    And I should <rowsPerPage> "Rows Per Page"
    And I should <action> "Action"
    And I should <activities> "Activities - Page"
    And I should <alphabetFilter> "ALL"
  
    Examples:
     | userRole       | quickSearch | timeFilter  | filter  | rowsPerPage | action  | activities | alphabetFilter |
     | DEMO           |             | see         | see     | see         | see     | see        | see            |
 
 ####### JOB ORDERS #######
    
  @javascript @joborders
  Scenario Outline: Job Orders module visibility
    Given I am logged in with <userRole> user role
    And I am on "/index.php?m=joborders"
    Then I should <addJobOrder> "Add Job Order"
    And I should <searchJobOrder> "Search Job Orders"
    And the page should <quickSearch> contain "Quick Search"
    And the page should <quickSearch> contain "quickSearchFor"
    And the page should <quickSearch> contain "quickSearch"
    And I should <jobOrdersHome> "Job Orders: Home"
    And the page should <selectView> contain "view"
    And the page should <onlyMyJobOrders> contain "onlyMyJobOrders"
    And the page should <onlyHotJobOrders> contain "onlyHotJobOrders"
    And I should <filter> "Filter"
    And I should <rowsPerPage> "Rows Per Page"
    And I should <action> "Action"
    And I should <jobOrders> "Job Orders - Page"
    And the page should <addToList> contain "Add To List"
    And the page should <export> contain "Export"
    And I should <alphabetFilter> "ALL"
     
  Examples:
     | userRole       | addJobOrder  | searchJobOrder  | quickSearch | jobOrdersHome | selectView | onlyMyJobOrders | onlyHotJobOrders | filter | rowsPerPage | action | jobOrders | addToList | export | alphabetFilter |
     | DEMO           | see          | see             |             | see           |            |                 |                  | see    | see         | see    | see       |           |        | see            |
     
  ####### CANDIDATES #######
     
  @javascript @candidates
  Scenario Outline: Candidates module visibility
    Given I am logged in with <userRole> user role
    And I am on "/index.php?m=candidates"
    Then I should <addCandidate> "Add Candidate"
    And I should <searchCandidate> "Search Candidates"
    And the page should <quickSearch> contain "Quick Search"
    And the page should <quickSearch> contain "quickSearchFor"
    And the page should <quickSearch> contain "quickSearch"
    And I should <candidatesHome> "Candidates: Home"
    And I should <filterByTag> "Filter by tag"
    And the page should <onlyMyCandidates> contain "onlyMyCandidates"
    And the page should <onlyHotCandidates> contain "onlyHotCandidates"
    And I should <filter> "Filter"
    And I should <rowsPerPage> "Rows Per Page"
    And I should <action> "Action"
    And I should <candidates> "Candidates - Page"
    And the page should <addToList> contain "Add To List"
    And the page should <export> contain "Export"
    And the page should <addToPipeline> contain "Add To Pipeline"
    And the page should <sendEmail> contain "Send E-Mail"
    And I should <alphabetFilter> "ALL"
    
   Examples:
     | userRole       | addCandidate | searchCandidate | quickSearch | candidatesHome | filterByTag | onlyMyCandidates| onlyHotCandidates| filter | rowsPerPage | action | candidates | addToList | export | addToPipeline | sendEmail | alphabetFilter |
     | DEMO           | see          | see             |             | see            | see         |                 |                  | see    | see         | see    | see        |           |        |               |           | see            |  
     
    ####### COMPANIES #######
    
    @javascript @companies
    Scenario Outline: Companies module visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=companies"
     Then I should <addCompany> "Add Company"
     And I should <searchCompany> "Search Companies"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And I should <companiesHome> "Companies: Home"
     And the page should <onlyMyCompanies> contain "onlyMyCompanies"
     And the page should <onlyHotCompanies> contain "onlyHotCompanies"
     And I should <filter> "Filter"
     And I should <rowsPerPage> "Rows Per Page"
     And I should <action> "Action"
     And I should <companies> "Companies - Page"
     And the page should <addToList> contain "Add To List"
     And the page should <export> contain "Export"
     And I should <alphabetFilter> "ALL"
    
    Examples:
     | userRole       | addCompany   | searchCompany   | quickSearch | companiesHome | onlyMyCompanies | onlyHotCompanies | filter | rowsPerPage | action | companies | addToList | export | alphabetFilter |
     | DEMO           | see          | see             |             | see           |                 |                  | see    | see         | see    | see       |           |        | see            |
     
   ####### CONTACTS #######
     
   @javascript @contacts
   Scenario Outline: Contacts module visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=contacts"
     Then I should <addContact> "Add Contact"
     And I should <searchContact> "Search Contacts"
     And I should <coldCallList> "Cold Call List"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And I should <contactsHome> "Contacts: Home"
     And the page should <onlyMyContacts> contain "onlyMyContacts"
     And the page should <onlyHotContacts> contain "onlyHotContacts"
     And I should <filter> "Filter"
     And I should <rowsPerPage> "Rows Per Page"
     And I should <action> "Action"
     And I should <contacts> "Contacts - Page"
     And the page should <addToList> contain "Add To List"
     And the page should <export> contain "Export"
     And I should <alphabetFilter> "ALL"
    
    Examples:
     | userRole       | addContact   | searchContact   | coldCallList | quickSearch | contactsHome | onlyMyContacts  | onlyHotContacts  | filter | rowsPerPage | action | contacts  | addToList | export | alphabetFilter |
     | DEMO           | see          | see             | see          |             | see          |                 |                  | see    | see         | see    | see       |           |        | see            |
     
     ####### LISTS #######
     
    @javascript @lists
    Scenario Outline: Lists module visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=lists"
     Then I should <showLists> "Show Lists"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And I should <listsHome> "Lists: Home"
     And I should <rowsPerPage> "Rows Per Page"
     And I should <lists> "Lists - Page"
     And I should <alphabetFilter> "ALL"
    
    Examples:
     | userRole       | showLists    | quickSearch | listsHome | rowsPerPage | lists    | alphabetFilter |
     | DEMO           | see          |             | see       | see         | see      | see            |
     
  ####### REPORTS #######
  
  @javascript @reports
    Scenario Outline: Reports module visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=reports"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And I should <timePeriods> "Today"
     And I should <timePeriods> "Yesterday"
     And I should <timePeriods> "This Week"
     And I should <timePeriods> "Last Week"
     And I should <timePeriods> "This Month"
     And I should <timePeriods> "Last Month"
     And I should <timePeriods> "This Year"
     And I should <timePeriods> "Last Year"
     And I should <timePeriods> "To Date"
    
    Examples:
     | userRole       | quickSearch  | timePeriods |
     | DEMO           |              | see         |
     
   ####### SETTINGS #######  

   @javascript @settings
   Scenario Outline: Settings module visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=settings"
     Then I should <viewProfile> "View Profile"
     And I should <changePassword> "Change Password"
     And I should <administration> "Administration"
     And I should <myProfile> "My Profile"
     And I should <download> "Downloads"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And I should <settingsHome> "Settings: My Profile"
    
    Examples:
     | userRole       | viewProfile  | changePassword  | administration | myProfile | download | quickSearch  | settingsHome |
     | DEMO           | see          | see             | see            | see       | see      |              | see          |
     
####### CALENDAR #######

  @javascript @calendar
    Scenario Outline: Calendar module visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=calendar"
     Then I should <upcomingEvents> "My Upcoming Events"
     And I should <addEvent> "Add Event"
     And I should <gotoToday> "Goto Today"
     And I should <myUpcomingEvents> "My Upcoming Events / Calls"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And the page should <hideNonPublic> contain "hideNonPublic"
     And the page should <switchPeriod> contain "userCalendarViewDay"
     And the page should <switchPeriod> contain "userCalendarViewWeek"
     And the page should <switchPeriod> contain "userCalendarViewMonth"
     And the page should <switchMonth> contain "linkMonthBack"
     And the page should <switchMonth> contain "linkMonthForeward"
     And the page should <calendarTable> contain "calendarMonth"
     
    Examples:
     | userRole       | upcomingEvents | addEvent | gotoToday | myUpcomingEvents | quickSearch  | hideNonPublic | switchPeriod | switchMonth | calendarTable |
     | DEMO           | see            | see      | see       | see              |              |               |              |             |               |
  
  
  

  ######## DASHBOARD(HOME) #######
  # no sub pages
  
  ####### ACTIVITIES #######
  # no sub pages
 
  ####### JOB ORDERS #######  
       
  @javascript @joborders
  Scenario Outline: Job Order Show page visibility
    Given I am logged in with <userRole> user role
    And I am on "/index.php?m=joborders"
    When I follow link "OpenCATS Tester"
    Then I should <addJobOrder> "Add Job Order"
    And I should <searchJobOrder> "Search Job Orders"
    And the page should <quickSearch> contain "Quick Search"
    And the page should <quickSearch> contain "quickSearchFor"
    And the page should <quickSearch> contain "quickSearch"
    And the page should <actionMenu> contain "showHideSingleQuickActionMenu"
    And I should <addAttachment> "Add Attachment"
    And I should <generateReport> "Generate Report"
    And I should <viewHistory> "View History"
    And I should <editJobOrder> "Edit"
    And I should <deleteJobOrder> "Delete"
    And I should <administrativeHideShow> "Administrative"
    And I should <addToPipeline> "Add Candidate to This Job Order Pipeline"
    And I should <export> "Export"
    And I should <details> "Job Order Details"
    And the page should <logAnActivity> contain "Log an Activity / Change Status"  
    And the page should <removeFromPipeline> contain "Remove from Pipeline"
    And the page should <setMatchingRating> contain "<map"
    And the page should <deleteAttachment> contain "index.php?m=joborders&amp;a=deleteAttachment"
     
  Examples:
     | userRole       | addJobOrder | searchJobOrder | quickSearch | actionMenu  | addAttachment | generateReport | viewHistory | editJobOrder  | deleteJobOrder  | administrativeHideShow | addToPipeline | export | details       | logAnActivity | removeFromPipeline | setMatchingRating | deleteAttachment |
     | DEMO           | see         | see            |             |             | see           | see            | see         | see           | see             | not see                | see           | see    | see           |               |                   |                 |                  |

  ####### CANDIDATES #######
  
   @javascript @candidates
   Scenario Outline: Candidate Show page visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=candidates"
     When I follow link "Pippin"
     Then I should <addCandidate> "Add Candidate"
     And I should <searchCandidate> "Search Candidates"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And the page should <actionMenu> contain "showHideSingleQuickActionMenu"
     And I should <details> "Candidate Details"
     And I should <scheduleEvent> "Schedule Event"
     And I should <addAttachment> "Add Attachment"
     And I should <editCandidate> "Edit"
     And I should <deleteCandidate> "Delete"
     And I should <viewHistory> "View History"
     And I should <administrativeHideShow> "Administrative"
     And the page should <addToPipeline> contain "Add This Candidate to Job Order Pipeline"
     And I should <logAnActivity> "Log an Activity"
     And the page should <logAnActivity2> contain "Log an Activity / Change Status"  
     And the page should <removeFromPipeline> contain "Remove from Pipeline"
     And the page should <editActivity> contain "editActivity"
     And the page should <deleteActivity> contain "deleteActivity"
     And the page should <setMatchingRating> contain "<map"
     And the page should <deleteAttachment> contain "index.php?m=candidates&amp;a=deleteAttachment"
     #When I click on "arrow"
     #Then the page should <addToList> contain "Add To List"
     #And the page should <addToPipeline> contain "Add To Pipeline"
     
   Examples:
     | userRole       | addCandidate | searchCandidate | quickSearch | actionMenu | addToList | details | scheduleEvent | addAttachment | editCandidate | deleteCandidate | viewHistory | administrativeHideShow | addToPipeline | logAnActivity2 | logAnActivity | removeFromPipeline | editActivity | deleteActivity | setMatchingRating | deleteAttachment |
     | DEMO           | see          | see             |             |            |           | see     | see           | see           | see           | see             | see         | not see                |               |                | see           |                    |              |                |                         |                  |

  ####### COMPANIES #######
   
    @javascript @companies
    Scenario Outline: Company Show page visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=companies"
     When I follow link "Google"
     Then I should <addCompany> "Add Company"
     And I should <searchCompany> "Search Companies"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And the page should <actionMenu> contain "showHideSingleQuickActionMenu"
     And I should <addAttachment> "Add Attachment"
     And I should <viewHistory> "View History"
     And I should <editCompany> "Edit"
     And I should <deleteCompany> "Delete"
     And I should <addJobOrder> "Add Job Order"
     And I should <addContact> "Add Contact"
     And the page should <editJobOrder> contain "index.php?m=joborders&amp;a=edit"  
     And the page should <editContact> contain "index.php?m=contacts&amp;a=edit"
     And the page should <deleteAttachment> contain "index.php?m=companies&amp;a=deleteAttachment"
     And the page should <sendEmail> contain "Send E-Mail"
     
     Examples:
     | userRole       | addCompany  | searchCompany  | quickSearch | actionMenu | addAttachment | viewHistory | editCompany   | deleteCompany   | addJobOrder | addContact | editJobOrder | editContact | deleteAttachment | sendEmail |
     | DEMO           | see         | see            |             |            | see           | see         | see           | see             | see         | see        |              |             |                  | not       |
     
  ####### CONTACTS #######
  
  @javascript @contacts
    Scenario Outline: Contacts Show page visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=contacts"
     When I follow link "Elizabeth"
     Then I should <addContact> "Add Contact"
     And I should <searchContact> "Search Contacts"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And the page should <actionMenu> contain "showHideSingleQuickActionMenu"
     And I should <coldCallList> "Cold Call List"
     And I should <scheduleEvent> "Schedule Event"
     And I should <viewHistory> "View History"
     And I should <editContact> "Edit"
     And I should <deleteContact> "Delete"
     And I should <logAnActivity> "Log an Activity"
     And the page should <editActivity> contain "editActivity"
     And the page should <deleteActivity> contain "deleteActivity"
     
     Examples:
     | userRole       | addContact   | searchContact   | actionMenu | quickSearch | coldCallList | scheduleEvent | viewHistory | editContact | deleteContact | logAnActivity | editActivity | deleteActivity |
     | DEMO           | see          | see             |            |             | see          | see           | see         | see         | see           | see           |              |                |
     
     
   ####### LISTS #######
       
   @javascript @lists
   Scenario Outline: Lists Show page visibility
     Given I am logged in with <userRole> user role
     And I am on "/index.php?m=lists"
     When I follow link "UK Candidates"
     Then I should <showLists> "Show Lists"
     And the page should <quickSearch> contain "Quick Search"
     And the page should <quickSearch> contain "quickSearchFor"
     And the page should <quickSearch> contain "quickSearch"
     And I should <deleteList> "Delete List"
     And I should <listsHome> "Lists:"
     And I should <filter> "Filter"
     And I should <rowsPerPage> "Rows Per Page"
     And I should <action> "Action"
     And I should <lists> "- Page"
     And I should <alphabetFilter> "ALL"
     And the page should <removeFromList> contain "Remove From This List"
     And the page should <addToPipeline> contain "Add To Pipeline"
     And the page should <sendEmail> contain "Send E-Mail"
     And the page should <export> contain "Export"
     
     Examples:
     | userRole       | showLists    | quickSearch | deleteList | listsHome | filter | rowsPerPage | action | lists  | alphabetFilter| removeFromList | addToPipeline | sendEmail | export |
     | DEMO           | see          |             | see        | see       | see    | see         | see    | see    | see           |                |               |           |        |
     
  ####### REPORTS #######
  # no sub pages
  
  ####### SETTINGS #######
  # no sub pages
  
  ####### CALENDAR #######
  # no sub pages

##missing checks for quick action menus on Show pages
     
     
     
     
     
@candidates @actions
Scenario Outline: Candidate module actions
  Given I am logged in with <userRole> user role
  
  When I do <type> request on url "<url>"
  Then I should <bool> have permission
  
  Examples:
  | userRole       | type    | url                                              | bool    |
  | DEMO           | GET     | index.php?m=candidates&a=show                    |         |
  | DEMO           | GET     | index.php?m=candidates&a=add                     |         |
  | DEMO           | GET     | index.php?m=candidates&a=edit                    |         |
  | DEMO           | GET     | index.php?m=candidates&a=delete                  |         |
  | DEMO           | GET     | index.php?m=candidates&a=search                  |         |
  | DEMO           | GET     | index.php?m=candidates&a=search&getback=getback  |         |
  | DEMO           | GET     | index.php?m=candidates&a=viewResume              |         |
  | DEMO           | GET     | index.php?m=candidates&a=considerForJobSearch    |         |
  | DEMO           | GET     | index.php?m=candidates&a=addToPipeline           |         |
  | DEMO           | GET     | index.php?m=candidates&a=addCandidateTags        |         |
  | DEMO           | GET     | index.php?m=candidates&a=addActivityChangeStatus |         |
  | DEMO           | GET     | index.php?m=candidates&a=removeFromPipeline      |         |
  | DEMO           | GET     | index.php?m=candidates&a=addEditImage            |         |
  | DEMO           | GET     | index.php?m=candidates&a=createAttachment        |         |
  | DEMO           | GET     | index.php?m=candidates&a=administrativeHideShow  | not     |
  | DEMO           | GET     | index.php?m=candidates&a=deleteAttachment        |         |
  | DEMO           | GET     | index.php?m=candidates&a=savedLists              |         |
  | DEMO           | GET     | index.php?m=candidates&a=emailCandidates         | not     |
  | DEMO           | GET     | index.php?m=candidates&a=show_questionnaire      |         |
  | DEMO           | GET     | index.php?m=candidates&a=listByView              |         |
  | DEMO           | POST    | index.php?m=candidates&a=add                     |         |
  | DEMO           | POST    | index.php?m=candidates&a=edit                    |         |
  | DEMO           | POST    | index.php?m=candidates&a=addCandidateTags        |         |
  | DEMO           | POST    | index.php?m=candidates&a=addActivityChangeStatus |         |
  | DEMO           | POST    | index.php?m=candidates&a=addEditImage            |         |
  | DEMO           | POST    | index.php?m=candidates&a=createAttachment        |         |
  

@joborders @actions
Scenario Outline: Job Order module actions
  Given I am logged in with <userRole> user role
  
  When I do <type> request on url "<url>"
  Then I should <bool> have permission
  
 Examples:
  | userRole       | type    | url                                             | bool |
  | DEMO           | GET     | index.php?m=joborders&a=show                    |      |
  | DEMO           | GET     | index.php?m=joborders&a=addJobOrderPopup        |      |
  | DEMO           | GET     | index.php?m=joborders&a=add                     |      |
  | DEMO           | GET     | index.php?m=joborders&a=addCandidateModal       |      |
  | DEMO           | GET     | index.php?m=joborders&a=edit                    |      |
  | DEMO           | GET     | index.php?m=joborders&a=delete                  |      |
  | DEMO           | GET     | index.php?m=joborders&a=search                  |      |
  | DEMO           | GET     | index.php?m=joborders&a=search&getback=getback  |      |
  | DEMO           | GET     | index.php?m=joborders&a=addActivityChangeStatus |      |
  | DEMO           | GET     | index.php?m=joborders&a=administrativeHideShow  | not  |
  | DEMO           | GET     | index.php?m=joborders&a=listByView              |      |
  | DEMO           | GET     | index.php?m=joborders&a=considerCandidateSearch |      |
  | DEMO           | GET     | index.php?m=joborders&a=addToPipeline           |      |
  | DEMO           | GET     | index.php?m=joborders&a=removeFromPipeline      |      |
  | DEMO           | GET     | index.php?m=joborders&a=createAttachment        |      |
  | DEMO           | GET     | index.php?m=joborders&a=deleteAttachment        |      |
  | DEMO           | POST    | index.php?m=joborders&a=add                     |      |
  | DEMO           | POST    | index.php?m=joborders&a=addCandidateModal       |      |
  | DEMO           | POST    | index.php?m=joborders&a=edit                    |      |
  | DEMO           | POST    | index.php?m=joborders&a=addActivityChangeStatus |      |
  | DEMO           | POST    | index.php?m=joborders&a=considerCandidateSearch |      |
  | DEMO           | POST    | index.php?m=joborders&a=createAttachment        |      |
  
  
 
  
 @companies @actions
 Scenario Outline: Companies module actions
  Given I am logged in with <userRole> user role
  
  When I do <type> request on url "<url>"
  Then I should <bool> have permission

Examples:
  | userRole       | type | url                                        | bool |
  | DEMO           | GET  | index.php?m=companies&a=show               |      |
  | DEMO           | GET  | index.php?m=companies&a=internalPostings   |      |
  | DEMO           | GET  | index.php?m=companies&a=add                |      |
  | DEMO           | GET  | index.php?m=companies&a=edit               |      |
  | DEMO           | GET  | index.php?m=companies&a=delete             |      |
  | DEMO           | GET  | index.php?m=companies&a=search             |      |
  | DEMO           | GET  | index.php?m=companies&a=search             |      |
  | DEMO           | GET  | index.php?m=companies&a=listByView         |      |
  | DEMO           | GET  | index.php?m=companies&a=createAttachment   |      |
  | DEMO           | GET  | index.php?m=companies&a=deleteAttachment   |      |
  | DEMO           | POST | index.php?m=companies&a=add                |      |                                                                        
  | DEMO           | POST | index.php?m=companies&a=edit               |      |                                                                      
  | DEMO           | POST | index.php?m=companies&a=createAttachment   |      |  
                                                                     


@contacts @actions
Scenario Outline: Contacts module actions
  Given I am logged in with <userRole> user role
  
  When I do <type> request on url "<url>"
  Then I should <bool> have permission
  
 Examples:
  | userRole       | type    | url                                             | bool  |
  | DEMO           | GET     | index.php?m=contacts&a=show                     |       |
  | DEMO           | GET     | index.php?m=contacts&a=add                      |       |
  | DEMO           | GET     | index.php?m=contacts&a=edit                     |       |
  | DEMO           | GET     | index.php?m=contacts&a=delete                   |       |
  | DEMO           | GET     | index.php?m=contacts&a=search                   |       |
  | DEMO           | GET     | index.php?m=contacts&a=search                   |       |
  | DEMO           | GET     | index.php?m=contacts&a=listByView               |       |
  | DEMO           | GET     | index.php?m=contacts&a=addActivityScheduleEvent |       |
  | DEMO           | GET     | index.php?m=contacts&a=showColdCallList         |       |
  | DEMO           | GET     | index.php?m=contacts&a=downloadVCard            |       |
  | DEMO           | POST    | index.php?m=contacts&a=add                      |       |                                                                        
  | DEMO           | POST    | index.php?m=contacts&a=edit                     |       |                                                                      
  | DEMO           | POST    | index.php?m=contacts&a=addActivityScheduleEvent |       |    
  
@activities @actions
Scenario Outline: Activity module actions
  Given I am logged in with <userRole> user role
  
  When I do <type> request on url "<url>"
  Then I should <bool> have permission 
  
  Examples:
  | userRole       | type | url                                        | bool |
  | DEMO           | GET  | index.php?m=activity&a=viewByDate          |      |
  | DEMO           | GET  | index.php?m=activity&a=listByViewDataGrid  |      |  
  | DEMO           | POST | index.php?m=activity&a=viewByDate          |      |
  
  
  
@dashboard @home @actions
Scenario Outline: Home module actions
  Given I am logged in with <userRole> user role
  
   When I do <type> request on url "<url>"
   Then I should <bool> have permission 
  
 Examples:
  | userRole       | type | url                                    | bool |
  | DEMO           | GET  | index.php?m=home&a=quickSearch         |      |
  | DEMO           | GET  | index.php?m=home&a=deleteSavedSearch   |      |
  | DEMO           | GET  | index.php?m=home&a=addSavedSearch      |      |
  | DEMO           | GET  | index.php?m=home&a=getAttachment       |      |
  | DEMO           | GET  | index.php?m=home&a=home                |      |
 
 
  
@lists @actions
Scenario Outline: Lists module actions
  Given I am logged in with <userRole> user role
  
   When I do <type> request on url "<url>"
   Then I should <bool> have permission 
  
 Examples:
  | userRole       | type | url                                            | bool |
  | DEMO           | GET  | index.php?m=lists&a=showList                   |      |
  | DEMO           | GET  | index.php?m=lists&a=quickActionAddToListModal  |      |
  | DEMO           | GET  | index.php?m=lists&a=addToListFromDatagridModal |      |
  | DEMO           | GET  | index.php?m=lists&a=removeFromListDatagrid     |      |
  | DEMO           | GET  | index.php?m=lists&a=deleteStaticList           |      |
  | DEMO           | GET  | index.php?m=lists&a=listByView                 |      |
  
  
 
@calendar @actions
Scenario Outline: Calendar module actions
  Given I am logged in with <userRole> user role
  
   When I do <type> request on url "<url>"
   Then I should <bool> have permission 
  
 Examples:
  | userRole       | type | url                                            | bool |
  | DEMO           | GET  | index.php?m=calendar&a=dynamicData             |      |
  | DEMO           | GET  | index.php?m=calendar&a=deleteEvent             |      |
  | DEMO           | GET  | index.php?m=calendar&a=showCalendar            |      |
  | DEMO           | POST | index.php?m=calendar&a=addEvent                |      |
  | DEMO           | POST | index.php?m=calendar&a=editEvent               |      |
  
  
@reports @actions
Scenario Outline: Reports module actions
  Given I am logged in with <userRole> user role
  
   When I do <type> request on url "<url>"
   Then I should <bool> have permission 
  
 Examples:
  | userRole       | type | url                                                | bool |
  | DEMO           | GET  | index.php?m=reports&a=graphView                    |      |
  | DEMO           | GET  | index.php?m=reports&a=generateJobOrderReportPDF    |      |
  | DEMO           | GET  | index.php?m=reports&a=showSubmissionReport         |      |
  | DEMO           | GET  | index.php?m=reports&a=showPlacementReport          |      |
  | DEMO           | GET  | index.php?m=reports&a=customizeJobOrderReport      |      |
  | DEMO           | GET  | index.php?m=reports&a=customizeEEOReport           |      |
  | DEMO           | GET  | index.php?m=reports&a=generateEEOReportPreview     |      |
  | DEMO           | GET  | index.php?m=reports&a=reports                      |      |
  
  
 @settings @actions
  Scenario Outline: Settings module actions
  Given I am logged in with <userRole> user role
  
   When I do <type> request on url "<url>"
   Then I should <bool> have permission 
  
   Examples:
  | userRole       | type | url                                        | bool | 
  | DEMO           | GET  | index.php?m=settings&a=tags                | not  |
  | DEMO           | POST | index.php?m=settings&a=changePassword      | not  |
  | DEMO           | POST | index.php?m=settings&a=manageUsers         |      |
  | DEMO           | POST | index.php?m=settings&a=professional        |      |
  | DEMO           | POST | index.php?m=settings&a=previewPage         |      |
  | DEMO           | POST | index.php?m=settings&a=previewPageTop      |      |
  | DEMO           | POST | index.php?m=settings&a=showUser            |      |
  | DEMO           | GET  | index.php?m=settings&a=addUser             |      |
  | DEMO           | POST | index.php?m=settings&a=addUser             |      |
  | DEMO           | GET  | index.php?m=settings&a=editUser            |      |
  | DEMO           | POST | index.php?m=settings&a=editUser            |      |
  | DEMO           | GET  | index.php?m=settings&a=createBackup        | not  |
  | DEMO           | GET  | index.php?m=settings&a=deleteBackup        | not  |
  | DEMO           | GET  | index.php?m=settings&a=customizeExtraFields| not  |
  | DEMO           | POST | index.php?m=settings&a=customizeExtraFields| not  |
  | DEMO           | GET  | index.php?m=settings&a=customizeCalendar   |      |
  | DEMO           | POST | index.php?m=settings&a=customizeCalendar   |      |
  | DEMO           | GET  | index.php?m=settings&a=reports             |      |
  | DEMO           | GET  | index.php?m=settings&a=emailSettings       |      |
  | DEMO           | POST | index.php?m=settings&a=emailSettings       |      |
  | DEMO           | GET  | index.php?m=settings&a=careerPortalQuestionnairePreview|      |
  | DEMO           | GET  | index.php?m=settings&a=careerPortalQuestionnaire       |      |
  | DEMO           | POST | index.php?m=settings&a=careerPortalQuestionnaire       |      |
  | DEMO           | GET  | index.php?m=settings&a=careerPortalQuestionnaireUpdate |      |
  | DEMO           | GET  | index.php?m=settings&a=careerPortalTemplateEdit        |      |
  | DEMO           | POST | index.php?m=settings&a=careerPortalTemplateEdit        |      |
  | DEMO           | GET  | index.php?m=settings&a=careerPortalSettings|      |
  | DEMO           | POST | index.php?m=settings&a=careerPortalSettings|      |
  | DEMO           | GET  | index.php?m=settings&a=eeo                 |      |
  | DEMO           | POST | index.php?m=settings&a=eeo                 |      |
  | DEMO           | GET  | index.php?m=settings&a=onCareerPortalTweak | not  |
  | DEMO           | GET  | index.php?m=settings&a=deleteUser          | not  |
  | DEMO           | GET  | index.php?m=settings&a=emailTemplates      |      |
  | DEMO           | POST | index.php?m=settings&a=emailTemplates      |      |
  | DEMO           | POST | index.php?m=settings&a=aspLocalization     | not  |
  | DEMO           | GET  | index.php?m=settings&a=loginActivity       |      |
  | DEMO           | GET  | index.php?m=settings&a=viewItemHistory     |      |
  | DEMO           | GET  | index.php?m=settings&a=getFirefoxModal     |      |
  | DEMO           | GET  | index.php?m=settings&a=downloads           |      |
  | DEMO           | GET  | index.php?m=settings&a=administration      |      |
  | DEMO           | POST | index.php?m=settings&a=administration      |      |
  | DEMO           | GET  | index.php?m=settings&a=myProfile           |      |
  