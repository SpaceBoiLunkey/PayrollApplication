package com.example.payroll;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;



@SpringBootApplication
public class PayrollApplication {

	public static void main(String... args) {
		SpringApplication.run(PayrollApplication.class, args);
	}
}



//serve on AWS
//configure project for Swagger
//add test cases for controller (Junit mockito framework)

//drop all tables, set up flyway, then execute that way do double underscores in between words!