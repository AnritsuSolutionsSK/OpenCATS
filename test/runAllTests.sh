#!/bin/sh
cd /var/www/public/
dockerize -wait tcp://opencats_test_mariadb:3306 -wait http://opencats_test_web:80 -timeout 30s
php modules/tests/waitForDb.php
cat config.php
./vendor/bin/phpunit src/OpenCATS/Tests/IntegrationTests
./vendor/bin/behat -v -c ./test/behat.yml --suite="default"
./vendor/bin/behat -v -c ./test/behat.yml --suite="security"
ln -sf demo_config.php config.php
./vendor/bin/behat -v -c ./test/behat.yml --suite="demo"
