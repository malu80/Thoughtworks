CREATE USER 'wiki' IDENTIFIED BY 'supersecret';
CREATE DATABASE wikidatabase;
GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki';
