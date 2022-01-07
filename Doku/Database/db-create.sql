CREATE DATABASE javaee_forum;
\connect javaee_forum;

create user javaee_forum_admin with password 'ultra_mega_secret_secure_password';
grant all on schema public to javaee_forum_admin;
alter schema public owner to javaee_forum_admin;