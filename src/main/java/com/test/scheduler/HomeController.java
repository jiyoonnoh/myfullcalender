package com.test.scheduler;

import java.net.Authenticator.RequestorType;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import schedule.service.ScheduleService;
import schedule.vo.ScheduleVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private ScheduleService service;

	// 일정 삭제하기
	@RequestMapping(value = "/delete", produces = "application/json; charset=utf-8")
	public String delete(@ModelAttribute("vo") ScheduleVO vo) {

		service.delete(vo);
		return "redirect:index";
	}

	// 일정 수정하기
	@RequestMapping(value = "/update", produces = "application/json; charset=utf-8")
	public String update(@ModelAttribute("vo") ScheduleVO vo) {

		service.update(vo);
		return "redirect:index";
	}

	// 일정 조회하기
	@ResponseBody
	@RequestMapping(value = "/GetEvents", produces = "application/json; charset=utf-8")
	public String GetEvents(@ModelAttribute("vo") ScheduleVO vo) {

		// JSONObject와 JSONArray 생성
		JSONArray jsonArr = new JSONArray();

		List<ScheduleVO> list = service.getevents(vo);

		for (int i = 0; i < list.size(); i++) {

			// 배열 안에 JSONObject 넣기
			JSONObject json = new JSONObject();

			ScheduleVO bean = list.get(i);

			// 종료날짜에 하루 추가 String to
			// 구글에서 날짜 더하기인데 date 형식으로 변환 , 하루더하고 , 스트링으로 다시변환 yyyy-MM-dd

			// bean.setEnddate("하루추가된날짜");

			json.put("title", bean.getTitle());
			json.put("start", bean.getStartdate());
			json.put("end", bean.getEnddate());
			json.put("no", bean.getNo());

			jsonArr.add(json);

		}

		return jsonArr.toString();

	}
	
  //일정추가 처리
	@RequestMapping(value = "/add" , produces = "application/json; charset=utf-8" , method = RequestMethod.POST)
	public String addsch(@ModelAttribute("vo") ScheduleVO vo) {
		
		service.insert(vo);			
		//홈화면으로 연결한다.
		return "redirect:index";
	}
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = { "/", "/index" }, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

}
