package com.zsh.mis.misconfig;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.config.server.EnableConfigServer;

@EnableDiscoveryClient
@EnableConfigServer
@SpringBootApplication
public class MisConfigApplication {

	public static void main(String[] args) {
		SpringApplication.run(MisConfigApplication.class, args);
	}
}
