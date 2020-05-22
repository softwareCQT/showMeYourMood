package com.softwareone.app.service;

import com.softwareone.app.bo.UpdateDiaryBo;
import com.softwareone.app.entity.Diary;
import com.baomidou.mybatisplus.extension.service.IService;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;

import java.util.List;

/***
 * @author chenqiting
 */
public interface DiaryService extends IService<Diary> {

    /***
     *增加日记
     * @param diary 日记
     * @param userId 用户
     * @return 保存是否成功
     */
    Result saveDiary(Diary diary, int userId);

    /***
     * 删除个人日记
     * @param id 日记的id
     * @param userId 用户标识
     * @return 删除是否成功
     */
    Result deleteOwnDiary(Integer id, Integer userId);


    /***
     * 批量删除日记
     * @param idList id的list
     * @param userId 用户标识
     * @return 删除是否成功
     */
    Result deleteBatchDiary(List<Integer> idList, Integer userId);

    /***
     * 更新日记新编辑的内容，多字段选取更新
     * @param diary 日记
     * @param userId 用户id
     * @return 更新是否成功
     */
    Result updateDiary(UpdateDiaryBo diary, Integer userId);

    /***
     * 可根据年月日来选
     * @param userId 用户标识
     * @param pageLimit 分页条件
     * @param year  年 （可无）
     * @param month 月 （可无）
     * @param day  日（可无）
     * @return 结果集
     */
    Result getDiaryByDate(Integer userId, PageLimit pageLimit, Integer year, Integer month, Integer day);
}

