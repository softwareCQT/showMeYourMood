package com.softwareone.app.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.softwareone.app.bo.UpdateLedgerBo;
import com.softwareone.app.entity.Ledger;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface LedgerMapper extends BaseMapper<Ledger> {
    /***
     *
     * @param pageLimit
     * @param year
     * @param month
     * @param day
     * @param userId
     * @return
     */
    List<Ledger> selectByPageAndTime(PageLimit pageLimit, Integer year, Integer month, Integer day,Integer type, Integer userId);

    /***
     * 查询数目
     * @param year
     * @param month
     * @param day
     * @param userId
     * @return
     */
    int selectCountByTime(Integer year, Integer month, Integer day,Integer type, Integer userId);

    /***
     *
     * @param userId
     * @param year
     * @param month
     * @param day
     * @param type
     * @param pay
     * @return
     */
    Double selectLedgerPay(Integer userId, Integer year, Integer month, Integer day, Integer type, boolean pay);

    /***
     *
     * @param updateLedgerBo
     * @return
     */
    int updateLedger(UpdateLedgerBo updateLedgerBo);
}