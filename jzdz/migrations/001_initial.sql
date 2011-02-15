### New Model: auth.Permission
CREATE TABLE "auth_permission" (
    "id" serial NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "content_type_id" integer NOT NULL,
    "codename" varchar(100) NOT NULL,
    UNIQUE ("content_type_id", "codename")
)
;
### New Model: auth.Group_permissions
CREATE TABLE "auth_group_permissions" (
    "id" serial NOT NULL PRIMARY KEY,
    "group_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED,
    UNIQUE ("group_id", "permission_id")
)
;
### New Model: auth.Group
CREATE TABLE "auth_group" (
    "id" serial NOT NULL PRIMARY KEY,
    "name" varchar(80) NOT NULL UNIQUE
)
;
ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "group_id_refs_id_3cea63fe" FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED;
### New Model: auth.User_user_permissions
CREATE TABLE "auth_user_user_permissions" (
    "id" serial NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED,
    UNIQUE ("user_id", "permission_id")
)
;
### New Model: auth.User_groups
CREATE TABLE "auth_user_groups" (
    "id" serial NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED,
    UNIQUE ("user_id", "group_id")
)
;
### New Model: auth.User
CREATE TABLE "auth_user" (
    "id" serial NOT NULL PRIMARY KEY,
    "username" varchar(30) NOT NULL UNIQUE,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(75) NOT NULL,
    "password" varchar(128) NOT NULL,
    "is_staff" boolean NOT NULL,
    "is_active" boolean NOT NULL,
    "is_superuser" boolean NOT NULL,
    "last_login" timestamp with time zone NOT NULL,
    "date_joined" timestamp with time zone NOT NULL
)
;
ALTER TABLE "auth_user_user_permissions" ADD CONSTRAINT "user_id_refs_id_f2045483" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "auth_user_groups" ADD CONSTRAINT "user_id_refs_id_831107f1" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED;
### New Model: auth.Message
CREATE TABLE "auth_message" (
    "id" serial NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "message" text NOT NULL
)
;
### New Model: contenttypes.ContentType
CREATE TABLE "django_content_type" (
    "id" serial NOT NULL PRIMARY KEY,
    "name" varchar(100) NOT NULL,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL,
    UNIQUE ("app_label", "model")
)
;
ALTER TABLE "auth_permission" ADD CONSTRAINT "content_type_id_refs_id_728de91f" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED;
### New Model: sessions.Session
CREATE TABLE "django_session" (
    "session_key" varchar(40) NOT NULL PRIMARY KEY,
    "session_data" text NOT NULL,
    "expire_date" timestamp with time zone NOT NULL
)
;
### New Model: sites.Site
CREATE TABLE "django_site" (
    "id" serial NOT NULL PRIMARY KEY,
    "domain" varchar(100) NOT NULL,
    "name" varchar(50) NOT NULL
)
;
### New Model: admin.LogEntry
CREATE TABLE "django_admin_log" (
    "id" serial NOT NULL PRIMARY KEY,
    "action_time" timestamp with time zone NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "content_type_id" integer REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
    "object_id" text,
    "object_repr" varchar(200) NOT NULL,
    "action_flag" smallint CHECK ("action_flag" >= 0) NOT NULL,
    "change_message" text NOT NULL
)
;
### New Model: flatpages.FlatPage_sites
CREATE TABLE "django_flatpage_sites" (
    "id" serial NOT NULL PRIMARY KEY,
    "flatpage_id" integer NOT NULL,
    "site_id" integer NOT NULL REFERENCES "django_site" ("id") DEFERRABLE INITIALLY DEFERRED,
    UNIQUE ("flatpage_id", "site_id")
)
;
### New Model: flatpages.FlatPage
CREATE TABLE "django_flatpage" (
    "id" serial NOT NULL PRIMARY KEY,
    "url" varchar(100) NOT NULL,
    "title" varchar(200) NOT NULL,
    "content" text NOT NULL,
    "enable_comments" boolean NOT NULL,
    "template_name" varchar(70) NOT NULL,
    "registration_required" boolean NOT NULL
)
;
ALTER TABLE "django_flatpage_sites" ADD CONSTRAINT "flatpage_id_refs_id_c0e84f5a" FOREIGN KEY ("flatpage_id") REFERENCES "django_flatpage" ("id") DEFERRABLE INITIALLY DEFERRED;
### New Model: ittybitty.IttyBittyURL
CREATE TABLE "ittybitty_ittybittyurl" (
    "id" serial NOT NULL PRIMARY KEY,
    "shortcut" varchar(10) NOT NULL UNIQUE,
    "url" varchar(200) NOT NULL UNIQUE,
    "hits" integer CHECK ("hits" >= 0) NOT NULL,
    "date_created" timestamp with time zone NOT NULL,
    "date_updated" timestamp with time zone NOT NULL
)
;
### New Model: dbtemplates.Template_sites
CREATE TABLE "django_template_sites" (
    "id" serial NOT NULL PRIMARY KEY,
    "template_id" integer NOT NULL,
    "site_id" integer NOT NULL REFERENCES "django_site" ("id") DEFERRABLE INITIALLY DEFERRED,
    UNIQUE ("template_id", "site_id")
)
;
### New Model: dbtemplates.Template
CREATE TABLE "django_template" (
    "id" serial NOT NULL PRIMARY KEY,
    "name" varchar(100) NOT NULL UNIQUE,
    "content" text NOT NULL,
    "creation_date" timestamp with time zone NOT NULL,
    "last_changed" timestamp with time zone NOT NULL
)
;
ALTER TABLE "django_template_sites" ADD CONSTRAINT "template_id_refs_id_9597e4d6" FOREIGN KEY ("template_id") REFERENCES "django_template" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "auth_permission_content_type_id" ON "auth_permission" ("content_type_id");
CREATE INDEX "auth_group_permissions_group_id" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_permission_id" ON "auth_group_permissions" ("permission_id");
CREATE INDEX "auth_user_user_permissions_user_id" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_permission_id" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "auth_user_groups_user_id" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_group_id" ON "auth_user_groups" ("group_id");
CREATE INDEX "auth_message_user_id" ON "auth_message" ("user_id");
CREATE INDEX "django_admin_log_user_id" ON "django_admin_log" ("user_id");
CREATE INDEX "django_admin_log_content_type_id" ON "django_admin_log" ("content_type_id");
CREATE INDEX "django_flatpage_sites_flatpage_id" ON "django_flatpage_sites" ("flatpage_id");
CREATE INDEX "django_flatpage_sites_site_id" ON "django_flatpage_sites" ("site_id");
CREATE INDEX "django_flatpage_url" ON "django_flatpage" ("url");
CREATE INDEX "django_flatpage_url_like" ON "django_flatpage" ("url" varchar_pattern_ops);
CREATE INDEX "django_template_sites_template_id" ON "django_template_sites" ("template_id");
CREATE INDEX "django_template_sites_site_id" ON "django_template_sites" ("site_id");
