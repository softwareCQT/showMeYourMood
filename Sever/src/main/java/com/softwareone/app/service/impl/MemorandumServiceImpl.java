package com.softwareone.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.softwareone.app.bo.SaveMemorandumBo;
import com.softwareone.app.bo.UpdateMemorandumBo;
import com.softwareone.app.constant.ResultConstant;
import com.softwareone.app.constant.SystemConstant;
import com.softwareone.app.handler.AsyncRedisHandler;
import com.softwareone.app.vo.PageData;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.softwareone.app.mapper.MemorandumMapper;
import com.softwareone.app.entity.Memorandum;
import com.softwareone.app.service.MemorandumService;

/**
 * @author chenqiting
 */
@Service
@Slf4j
public class MemorandumServiceImpl extends ServiceImpl<MemorandumMapper, Memorandum> implements MemorandumService {

    @Resource
    private MemorandumMapper memorandumMapper;
    @Resource(name = "redisTemplate")
    private ZSetOperations<String, Memorandum> zSetOperations;
    /***
     * 延时任务队列在这里实现
     */
    @Resource(name = "task")
    private ThreadPoolTaskScheduler threadPoolTaskScheduler;
    @Resource
    private AsyncRedisHandler asyncRedisHandler;

    @PostConstruct
    public void start() {
        threadPoolTaskScheduler.scheduleAtFixedRate(asyncRedisHandler, 5000);
    }

    @Override
    public Result getMemorandum(PageLimit pageLimit, Integer userId) {
        List<Memorandum> memorandums = memorandumMapper.selectByIdAndPage(pageLimit, userId);
        int size = memorandumMapper.selectCount(new QueryWrapper<Memorandum>().eq(Memorandum.COL_USER_ID, userId));
        PageData<List<Memorandum>> listPageData = new PageData<>(size, memorandums);
        return new Result<>(listPageData);
    }

    @Override
    public Result deleteMemorandumById(int id, Integer userId) {
        Memorandum memorandum = memorandumMapper.selectById(id);
        if (memorandum.getUserId().compareTo(userId) == 0) {
            zSetOperations.remove(SystemConstant.REMEMBER_KEY, memorandum);
        }
        memorandumMapper.delete(new UpdateWrapper<Memorandum>().eq(Memorandum.COL_USER_ID, userId).eq(Memorandum.COL_ID, id));
        return ResultConstant.OK;
    }

    @Override
    public Result saveMemorandum(SaveMemorandumBo saveMemorandumBo, Integer userId) {
        saveMemorandumBo.getMemorandum().setUserId(userId);
        memorandumMapper.insert(saveMemorandumBo.getMemorandum());
        zSetOperations.add(SystemConstant.REMEMBER_KEY, saveMemorandumBo.getMemorandum(), saveMemorandumBo.getDate().getTime());
        return ResultConstant.OK;
    }

    @Override
    public Result deleteBatchMemorandum(List<Integer> idList, Integer userId) {
        List<Memorandum> list = memorandumMapper.selectBatchIds(idList);
        for (Memorandum memorandum : list) {
            if (memorandum.getUserId().compareTo(userId) == 0){
                zSetOperations.remove(SystemConstant.REMEMBER_KEY, memorandum);
            }else {
                idList.remove(memorandum.getId());
            }
        }
        memorandumMapper.delete(new UpdateWrapper<Memorandum>().in(Memorandum.COL_ID,idList));
        return ResultConstant.OK;
    }

    @Override
    public Result updateMemorandum(UpdateMemorandumBo updateMemorandumBo) {
        memorandumMapper.updateContentById(updateMemorandumBo);
        return ResultConstant.OK;
    }
}

