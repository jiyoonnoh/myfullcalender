package schedule.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import schedule.dao.ScheduleDAO;
import schedule.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired private ScheduleDAO dao;

	@Override
	public boolean insert(ScheduleVO vo) {
		return dao.insert(vo);
	}

	@Override
	public List<ScheduleVO> getevents(ScheduleVO vo) {
		return dao.getevents(vo);
	}

	@Override
	public boolean update(ScheduleVO vo) {
		return dao.update(vo);
	}

	@Override
	public boolean delete(ScheduleVO vo) {
		return dao.delete(vo);
	}
	
	

}
