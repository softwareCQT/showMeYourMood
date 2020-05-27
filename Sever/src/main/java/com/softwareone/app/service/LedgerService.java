package com.softwareone.app.service;

import com.softwareone.app.bo.UpdateLedgerBo;
import com.softwareone.app.entity.Ledger;
import com.baomidou.mybatisplus.extension.service.IService;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;

public interface LedgerService extends IService<Ledger>{

    /***
     * 保存账本
     * @param ledger
     * @return 保存是否成功
     */
    Result saveLedger(Ledger ledger);

    /***
     * 得到账本
     * @param pageLimit 分页条件
     * @param year 年 （可不传）
     * @param month 月 （可不传）
     * @param day 天 （可不传）
     * @param userId 唯一标识
     * @param type 类型
     * @return 账本
     */
    Result getLedgerByPageAndTime(PageLimit pageLimit, Integer year, Integer month, Integer day, Integer type, Integer userId);

    /***
     * 对账本的收入和支出进行统计
     *
     * @param type 账本的类型（记哪种）（可不传）
     * @param userId 唯一标识
     * @param year 年 （可不传）
     * @param month 月 （可不传）
     * @param day 天 （可不传）
     * @return 数据
     */
    Result sumLedgerOnTimeOrAll(Integer userId, Integer year, Integer month, Integer day, Integer type);

    /****
     * 删除账本
     * @param id 账本的id
     * @param userId id
     * @return
     */
    Result deleteLedger(Integer id, Integer userId);

    /***
     *更新账本
     * @param updateLedgerBo 更新信息
     * @param userId 用户唯一标识
     * @return
     */
    Result updateLedger(UpdateLedgerBo updateLedgerBo, Integer userId);
}
