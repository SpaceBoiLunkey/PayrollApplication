package com.example.payroll;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class PayrollApplication {

	public static void main(String... args) {
		SpringApplication.run(PayrollApplication.class, args);
	}
}

//rename database naming conventions from "employeeId" to just id
//create schema if not exists "employee_schema"
//rename file to V1__initdb.sql
//create new columns for "created_at" with the timestamp
//safe/soft delete database
//refactor after moving into packages
//serve on AWS
//configure project for Swagger
//add test cases for controller (Junit mockito framework)

//drop all tables, set up flyway, then execute that way do double underscores in between words!