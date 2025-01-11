# Определения путей и переменных
APP_PATH := ./app
VENDOR_PATH := ./vendor
BIN_PATH := /usr/local/bin

# Определение основных целей
install: composer-install node-modules-install

composer-install:
	composer install --no-interaction --prefer-dist --optimize-autoloader

node-modules-install:
	npm install

serve:
	php artisan serve

migrate:
	php artisan migrate

test:
	vendor/bin/phpunit

clean:
	rm -rf $(VENDOR_PATH)
	rm -rf node_modules

.PHONY: install composer-install node-modules-install serve migrate test clean
