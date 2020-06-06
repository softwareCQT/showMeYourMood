package com.softwareone.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.softwareone.app.bo.UpdateDiaryBo;
import com.softwareone.app.constant.ResultConstant;
import com.softwareone.app.entity.Diary;
import com.softwareone.app.mapper.DiaryMapper;
import com.softwareone.app.service.DiaryService;
import com.softwareone.app.vo.PageData;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

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
        Diary diary1 = diaryMapper.selectOne(new QueryWrapper<Diary>().eq(Diary.COL_DATE, diary.getDate()).eq(Diary.COL_USER_ID, userId));
        //不能重复添加日记
        if (Objects.nonNull(diary1)) {
            return ResultConstant.DIARY_EXIST;
        }
        //设置好用户
        diary.setUserId(userId);
        diaryMapper.insert(diary);
        return ResultConstant.OK;
    }

    @Override
    public Result deleteOwnDiary(Integer id, Integer userId) {
        diaryMapper.delete(new UpdateWrapper<Diary>().eq(Diary.COL_USER_ID, userId).eq(Diary.COL_ID, id));
        return ResultConstant.OK;
    }

    @Override
    public Result deleteBatchDiary(List<Integer> idList, Integer userId) {
        diaryMapper.delete(new UpdateWrapper<Diary>().eq(Diary.COL_USER_ID, userId).in(Diary.COL_ID, idList));
        return ResultConstant.OK;
    }

    @Override
    public Result updateDiary(UpdateDiaryBo diary, Integer userId) {
        boolean flag = Objects.isNull(diary.getContent()) && Objects.isNull(diary.getDate())
                && Objects.isNull(diary.getWeather()) && Objects.isNull(diary.getEmoji());
        //有内容传进来需要修改时
        if (!flag) {
            diaryMapper.updateByType(diary, userId);
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

