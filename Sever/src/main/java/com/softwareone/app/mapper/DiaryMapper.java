package com.softwareone.app.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.softwareone.app.bo.UpdateDiaryBo;
import com.softwareone.app.entity.Diary;
import com.softwareone.app.vo.PageLimit;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;


/***
 * @author chenqiting
 */
@Mapper
public interface DiaryMapper extends BaseMapper<Diary> {
    /***
     * 更新
     * @param diary 日记
     * @param userId 标识
     * @return 更新条数
     */
    int updateByType(UpdateDiaryBo diary, Integer userId);

    /***
     *根据年月日获取并分页
     * @param userId 用户
     * @param pageLimit 分页条件
     * @param year 年
     * @param month 月
     * @param day 日
     */
      List<Diary> selectDiaryByDateAndPage(Integer userId, PageLimit pageLimit, Integer year, Integer month, Integer day);

    /***
     *获取条数
     * @param userId 用户
     * @param year 年
     * @param month 月
     * @param day 日
     * @return
     */
    int selectCountByDate(Integer userId, Integer year, Integer month, Integer day);
}