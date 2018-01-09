package com.zsh.mis.misgateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@EnableDiscoveryClient
@SpringBootApplication
public class MisGatewayApplication {

	public static void main(String[] args) {
		SpringApplication.run(MisGatewayApplication.class, args);
	}
}
