package com.softwareone.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.softwareone.app.bo.UpdateMemorandumBo;
import com.softwareone.app.constant.ResultConstant;
import com.softwareone.app.vo.PageData;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.softwareone.app.mapper.MemorandumMapper;
import com.softwareone.app.entity.Memorandum;
import com.softwareone.app.service.MemorandumService;

/**
 * @author chenqiting
 */
@Service
@RequiredArgsConstructor
public class MemorandumServiceImpl extends ServiceImpl<MemorandumMapper, Memorandum> implements MemorandumService {

    @NonNull
    private MemorandumMapper memorandumMapper;

    @Override
    public Result getMemorandum(PageLimit pageLimit, Integer userId) {
        List<Memorandum> memorandums = memorandumMapper.selectByIdAndPage(pageLimit, userId);
        int size = memorandumMapper.selectCount(new QueryWrapper<Memorandum>().eq(Memorandum.COL_USER_ID, userId));
        PageData<List<Memorandum>> listPageData = new PageData<>(size, memorandums);
        return new Result<>(listPageData);
    }

    @Override
    public Result deleteMemorandumById(int id) {
        memorandumMapper.deleteById(id);
        return ResultConstant.OK;
    }

    @Override
    public Result saveMemorandum(Memorandum memorandum, Integer userId) {
        memorandum.setUserId(userId);
        memorandumMapper.insert(memorandum);
        return ResultConstant.OK;
    }

    @Override
    public Result deleteBatchMemorandum(List<Integer> idList) {
        memorandumMapper.deleteBatchIds(idList);
        return ResultConstant.OK;
    }

    @Override
    public Result updateMemorandum(UpdateMemorandumBo updateMemorandumBo) {
        memorandumMapper.updateContentById(updateMemorandumBo);
        return ResultConstant.OK;
    }
}

