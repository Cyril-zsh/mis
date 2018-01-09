package com.zsh.mis.misuaa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@EnableDiscoveryClient
@SpringBootApplication
public class MisUaaApplication {

	public static void main(String[] args) {
		SpringApplication.run(MisUaaApplication.class, args);
	}
}
