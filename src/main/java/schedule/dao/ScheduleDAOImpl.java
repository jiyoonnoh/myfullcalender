package schedule.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import schedule.vo.ScheduleVO;

@Repository
public class ScheduleDAOImpl implements ScheduleDAO {
	@Autowired private SqlSession sql;
	
	@Override
	public boolean insert(ScheduleVO vo) {
		return sql.insert("schedule.mapper.insert", vo)>0? true : false ;
	}

	@Override
	public List<ScheduleVO> getevents(ScheduleVO vo) {
		return sql.selectList("schedule.mapper.getevents", vo);
	}

	@Override
	public boolean update(ScheduleVO vo) {
		return sql.update("schedule.mapper.update", vo)>0? true : false;
	}

	@Override
	public boolean delete(ScheduleVO vo) {
		return sql.delete("schedule.mapper.delete", vo)>0? true : false;
	}

}
