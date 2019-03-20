package schedule.service;

import java.util.List;

import schedule.vo.ScheduleVO;

public interface ScheduleService {
	//CRUD
	boolean insert(ScheduleVO vo);

	List<ScheduleVO> getevents(ScheduleVO vo);
	
	boolean update(ScheduleVO vo);
	
	boolean delete(ScheduleVO vo);

}
