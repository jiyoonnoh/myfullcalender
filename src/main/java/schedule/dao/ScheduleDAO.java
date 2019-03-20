package schedule.dao;

import java.util.List;

import schedule.vo.ScheduleVO;

public interface ScheduleDAO {
	//CRUD
	boolean insert(ScheduleVO vo);

	public List<ScheduleVO> getevents(ScheduleVO vo);
	
	boolean update(ScheduleVO vo);
	
	boolean delete(ScheduleVO vo);
}
