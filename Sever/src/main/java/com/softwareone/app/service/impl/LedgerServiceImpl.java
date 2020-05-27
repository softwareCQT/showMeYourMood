package com.softwareone.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.softwareone.app.bo.UpdateLedgerBo;
import com.softwareone.app.constant.ResultConstant;
import com.softwareone.app.vo.PageData;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.PayAndGaveVo;
import com.softwareone.app.vo.Result;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.softwareone.app.mapper.LedgerMapper;
import com.softwareone.app.entity.Ledger;
import com.softwareone.app.service.LedgerService;
@Service
public class LedgerServiceImpl extends ServiceImpl<LedgerMapper, Ledger> implements LedgerService{
    @Resource
    private LedgerMapper ledgerMapper;

    @Override
    public Result saveLedger(Ledger ledger) {
        ledgerMapper.insert(ledger);
        return ResultConstant.OK;
    }

    @Override
    public Result getLedgerByPageAndTime(PageLimit pageLimit, Integer year, Integer month, Integer day, Integer type, Integer userId) {
        //查询数据
       List<Ledger> resultList = ledgerMapper.selectByPageAndTime(pageLimit,year, month, day,type, userId);
       //查询数目
       int count = ledgerMapper.selectCountByTime(year, month, day, userId);

       return new Result<>(new PageData<>(count, resultList));
    }

    @Override
    public Result sumLedgerOnTimeOrAll(Integer userId, Integer year, Integer month, Integer day, Integer type) {
        //统计收入，统计支出
        Double pay = ledgerMapper.selectLedgerPay(userId, year, month, day, type, true);
        Double gave = ledgerMapper.selectLedgerPay(userId, year, month, day, type, false);
        if (Objects.isNull(pay)){
            pay = 0.0;
        }
        if (Objects.isNull(gave)) {
            gave = 0.0;
        }
        return new Result<>(new PayAndGaveVo(pay, gave));
    }

    @Override
    public Result deleteLedger(Integer id, Integer userId) {
        int result = ledgerMapper.delete(new UpdateWrapper<Ledger>().eq(Ledger.COL_ID, id).eq(Ledger.COL_USER_ID, userId));
        if (result == 0){
            return ResultConstant.SYSTEM_ERROR;
        }
        return ResultConstant.OK;
    }

    @Override
    public Result updateLedger(UpdateLedgerBo updateLedgerBo, Integer userId) {
        if (Objects.isNull(updateLedgerBo.getDate()) && Objects.isNull(updateLedgerBo.getMoney()) && Objects.isNull(updateLedgerBo.getRemark())
            && Objects.isNull(updateLedgerBo.getType()) && Objects.isNull(updateLedgerBo.getPay())) {
            return ResultConstant.OK;
        }
        Ledger ledger = ledgerMapper.selectById(updateLedgerBo.getId());
        if (Objects.isNull(ledger) || ledger.getUserId().compareTo(userId) != 0) {
            return ResultConstant.PERMISSION_DENIED;
        }
        ledgerMapper.updateLedger(updateLedgerBo);
        return ResultConstant.OK;
    }
}
