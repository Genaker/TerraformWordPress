terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-rds.git?ref=v3.0.0"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../wp_vpc", "../db_security"]
}

dependency "wp_vpc" {
  config_path = "../wp_vpc"
}

dependency "db_security" {
  config_path = "../db_security"
}

###########################################################
# View all available inputs for this module:
# https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/3.0.0?tab=inputs
###########################################################
inputs = {
  # The allocated storage in gigabytes
  # type: string
  allocated_storage = "9"

  # The days to retain backups for
  # type: number
  backup_retention_period = 0

  # The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window
  # type: string
  backup_window = ""

  # Whether to create a database subnet group
  # type: bool
  create_db_subnet_group = false

  #  of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC
  # type: string
  db_subnet_group_name = dependency.wp_vpc.outputs.database_subnet_group

  # This should NOT create an option group since they are not supported for PostgreSQL
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithOptionGroups.html
  # for MySQL
  option_group_name = "my-option-group"
  option_group_use_name_prefix = false
  
  parameter_group_name = "my-parameter-group"
  parameter_group_use_name_prefix = false
  
  # The database engine to use
  # type: string
  # engine = "postgres"
  
  # For MySQL
  engine = "mariadb"

  # The engine version to use
  # type: string
  # engine_version = "12.8"
  
  # For MySQL
  engine_version = "10.4.13"

  # The family of the DB parameter group
  # type: string
  # family = "postgres12"
  
  # For MySQL
  family = "mariadb10.4"
  
  # The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier
  # Notice: only lowercase alphanumeric characters and hyphens allowed in "identifier"
  # type: string
  identifier = "mysql-wp"

  # The instance type of the RDS instance
  # type: string
  instance_class = "db.m6g.large"

  # The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'
  # type: string
  maintenance_window = ""

  # Specifies the major version of the engine that this option group should be associated with
  # type: string
  # major_engine_version = "12"
  
  # For MySQL
  major_engine_version = "10.4"

  # Specifies if the RDS instance is multi-AZ
  # type: bool
  multi_az = false

  # Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file
  # type: string
  password = "fgh54gfhfgjhjD"

  # The port on which the DB accepts connections
  # type: string
  port = "3306"

  # Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier
  # type: bool
  skip_final_snapshot = true

  # Username for the master DB user
  # type: string
  username = "wp_user"

  # List of VPC security groups to associate
  # type: list(string)
  vpc_security_group_ids = [dependency.db_security.outputs.security_group_id]

  
}
