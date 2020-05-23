package com.softwareone.app.service.impl;

import com.softwareone.app.bo.UpdateDiaryBo;
import com.softwareone.app.constant.ResultConstant;
import com.softwareone.app.vo.PageData;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.softwareone.app.entity.Diary;
import com.softwareone.app.mapper.DiaryMapper;
import com.softwareone.app.service.DiaryService;

/***
 * @author chenqiting
 */
@Service
@RequiredArgsConstructor
public class DiaryServiceImpl extends ServiceImpl<DiaryMapper, Diary> implements DiaryService {

    @NonNull
    private DiaryMapper diaryMapper;
    @Override
    public Result saveDiary(Diary diary, int userId) {
        //设置好用户
        diary.setUserId(userId);
        diaryMapper.insert(diary);
        return ResultConstant.OK;
    }

    @Override
    public Result deleteOwnDiary(Integer id) {
        diaryMapper.deleteById(id);
        return ResultConstant.OK;
    }

    @Override
    public Result deleteBatchDiary(List<Integer> idList) {
        diaryMapper.deleteBatchIds(idList);
        return ResultConstant.OK;
    }

    @Override
    public Result updateDiary(UpdateDiaryBo diary) {
        boolean flag = Objects.isNull(diary.getContent()) && Objects.isNull(diary.getDate())
                && Objects.isNull(diary.getWeather()) && Objects.isNull(diary.getEmoji());
        //有内容传进来需要修改时
        if (!flag){
            diaryMapper.updateByType(diary);
        }
        return ResultConstant.OK;
    }

    @Override
    public Result getDiaryByDate(Integer userId, PageLimit pageLimit, Integer year, Integer month, Integer day) {
        List<Diary> list = diaryMapper.selectDiaryByDateAndPage(userId, pageLimit, year, month, day);
        int size = diaryMapper.selectCountByDate(userId, year, month, day);
        PageData<List> pageData = new PageData<>(size, list);
        return new Result<>(pageData);
    }
}

