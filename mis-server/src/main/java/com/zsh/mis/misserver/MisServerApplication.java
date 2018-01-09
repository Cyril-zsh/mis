package com.zsh.mis.misserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@EnableEurekaServer
@SpringBootApplication
public class MisServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(MisServerApplication.class, args);
	}
}
