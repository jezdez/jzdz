### New Model: auth.Permission
CREATE TABLE "auth_permission" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "content_type_id" integer NOT NULL,
    "codename" varchar(100) NOT NULL,
    UNIQUE ("content_type_id", "codename")
)
;
### New Model: auth.Group_permissions
CREATE TABLE "auth_group_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "group_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("group_id", "permission_id")
)
;
### New Model: auth.Group
CREATE TABLE "auth_group" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(80) NOT NULL UNIQUE
)
;
### New Model: auth.User_user_permissions
CREATE TABLE "auth_user_user_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("user_id", "permission_id")
)
;
### New Model: auth.User_groups
CREATE TABLE "auth_user_groups" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id"),
    UNIQUE ("user_id", "group_id")
)
;
### New Model: auth.User
CREATE TABLE "auth_user" (
    "id" integer NOT NULL PRIMARY KEY,
    "username" varchar(30) NOT NULL UNIQUE,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(75) NOT NULL,
    "password" varchar(128) NOT NULL,
    "is_staff" bool NOT NULL,
    "is_active" bool NOT NULL,
    "is_superuser" bool NOT NULL,
    "last_login" datetime NOT NULL,
    "date_joined" datetime NOT NULL
)
;
### New Model: auth.Message
CREATE TABLE "auth_message" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "message" text NOT NULL
)
;
### New Model: contenttypes.ContentType
CREATE TABLE "django_content_type" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(100) NOT NULL,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL,
    UNIQUE ("app_label", "model")
)
;
### New Model: sessions.Session
CREATE TABLE "django_session" (
    "session_key" varchar(40) NOT NULL PRIMARY KEY,
    "session_data" text NOT NULL,
    "expire_date" datetime NOT NULL
)
;
### New Model: sites.Site
CREATE TABLE "django_site" (
    "id" integer NOT NULL PRIMARY KEY,
    "domain" varchar(100) NOT NULL,
    "name" varchar(50) NOT NULL
)
;
### New Model: admin.LogEntry
CREATE TABLE "django_admin_log" (
    "id" integer NOT NULL PRIMARY KEY,
    "action_time" datetime NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "content_type_id" integer REFERENCES "django_content_type" ("id"),
    "object_id" text,
    "object_repr" varchar(200) NOT NULL,
    "action_flag" smallint unsigned NOT NULL,
    "change_message" text NOT NULL
)
;
### New Model: flatpages.FlatPage_sites
CREATE TABLE "django_flatpage_sites" (
    "id" integer NOT NULL PRIMARY KEY,
    "flatpage_id" integer NOT NULL,
    "site_id" integer NOT NULL REFERENCES "django_site" ("id"),
    UNIQUE ("flatpage_id", "site_id")
)
;
### New Model: flatpages.FlatPage
CREATE TABLE "django_flatpage" (
    "id" integer NOT NULL PRIMARY KEY,
    "url" varchar(100) NOT NULL,
    "title" varchar(200) NOT NULL,
    "content" text NOT NULL,
    "enable_comments" bool NOT NULL,
    "template_name" varchar(70) NOT NULL,
    "registration_required" bool NOT NULL
)
;
### New Model: ittybitty.IttyBittyURL
CREATE TABLE "ittybitty_ittybittyurl" (
    "id" integer NOT NULL PRIMARY KEY,
    "shortcut" varchar(10) NOT NULL UNIQUE,
    "url" varchar(200) NOT NULL UNIQUE,
    "hits" integer unsigned NOT NULL,
    "date_created" datetime NOT NULL,
    "date_updated" datetime NOT NULL
)
;
### New Model: dbtemplates.Template_sites
CREATE TABLE "django_template_sites" (
    "id" integer NOT NULL PRIMARY KEY,
    "template_id" integer NOT NULL,
    "site_id" integer NOT NULL REFERENCES "django_site" ("id"),
    UNIQUE ("template_id", "site_id")
)
;
### New Model: dbtemplates.Template
CREATE TABLE "django_template" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(100) NOT NULL UNIQUE,
    "content" text NOT NULL,
    "creation_date" datetime NOT NULL,
    "last_changed" datetime NOT NULL
)
;
CREATE INDEX "auth_permission_e4470c6e" ON "auth_permission" ("content_type_id");
CREATE INDEX "auth_group_permissions_bda51c3c" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_1e014c8f" ON "auth_group_permissions" ("permission_id");
CREATE INDEX "auth_user_user_permissions_fbfc09f1" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_1e014c8f" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "auth_user_groups_fbfc09f1" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_bda51c3c" ON "auth_user_groups" ("group_id");
CREATE INDEX "auth_message_fbfc09f1" ON "auth_message" ("user_id");
CREATE INDEX "django_admin_log_fbfc09f1" ON "django_admin_log" ("user_id");
CREATE INDEX "django_admin_log_e4470c6e" ON "django_admin_log" ("content_type_id");
CREATE INDEX "django_flatpage_sites_dedefef8" ON "django_flatpage_sites" ("flatpage_id");
CREATE INDEX "django_flatpage_sites_6223029" ON "django_flatpage_sites" ("site_id");
CREATE INDEX "django_flatpage_a4b49ab" ON "django_flatpage" ("url");
CREATE INDEX "django_template_sites_1e0a3f4a" ON "django_template_sites" ("template_id");
CREATE INDEX "django_template_sites_6223029" ON "django_template_sites" ("site_id");
