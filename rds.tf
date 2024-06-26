#Creating DB subnet
resource "aws_db_subnet_group" "db-subnet" {
  name       = "db-subnet"
  subnet_ids = [aws_subnet.dev_subnet3.id,aws_subnet.dev_subnet4.id]

  tags = {
    Name = "DB subnet group"
  }
}

#creating DB instacne
resource "aws_db_instance" "db-instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  identifier             = "db-instance2"
  db_name                = "vijayadb1"
  username               = "main"
  password               = "lab-username"
  multi_az = true

  backup_retention_period = 7
  skip_final_snapshot       = false
  final_snapshot_identifier = "mssql-final-snapshot"

  db_subnet_group_name   = aws_db_subnet_group.db-subnet.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

}
  
output "rds_endpoint" {
  description = "rds endpoint"
  value = aws_db_instance.db-instance.endpoint


  } 
  



    
  
