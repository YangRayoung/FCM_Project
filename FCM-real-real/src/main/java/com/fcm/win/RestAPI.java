package com.fcm.win;

import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RestController
public class RestAPI {
	
	@RequestMapping("/prediction")
	public @ResponseBody Map<String , Object> saveCode (@RequestBody Map<String, Object> param) {
		remainVO.setA((int)param.get("A"));
	    remainVO.setB((int)param.get("B"));
	    remainVO.setC((int)param.get("C"));
	    remainVO.setD((int)param.get("D"));
	    remainVO.setE((int)param.get("E"));
		
	    return param;
	}
}
