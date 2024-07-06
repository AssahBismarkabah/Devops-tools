package com.cloud_infra.prac;

import org.springframework.boot.SpringApplication;

public class TestPracApplication {

	public static void main(String[] args) {
		SpringApplication.from(PracApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
