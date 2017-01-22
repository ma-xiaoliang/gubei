package com.bruce.geekway.controller.game;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/gub")
public class InteractionGameController {

	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, HttpServletResponse response) {

		return "index";
	}

}
