package com.softwareone.app.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.softwareone.app.bo.SaveMemorandumBo;
import com.softwareone.app.bo.UpdateMemorandumBo;
import com.softwareone.app.entity.Memorandum;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;

import java.util.List;

/**
 * @author chenqiting
 */
public interface MemorandumService extends IService<Memorandum> {

    /***
     * 获取备忘录的数据
     * @param pageLimit 页面限制
     * @param userId 用户id
     * @return
     */
    Result getMemorandum(PageLimit pageLimit, Integer userId);

    /***
     * 根据id删除
     * @param id id
     * @param userId
     * @return 删除是否成功
     */
    Result deleteMemorandumById(int id, Integer userId);

    /***
     * 存储备忘录
     * @param saveMemorandumBo 备忘录的信息和需要通知的时间
     * @param userId 用户id
     * @return 存储是否成功
     */
    Result saveMemorandum(SaveMemorandumBo saveMemorandumBo, Integer userId);

    /***
     * 批量删除
     * @param idList id的集合
     * @param userId
     * @return 数据
     */
    Result deleteBatchMemorandum(List<Integer> idList, Integer userId);

    /***
     * 更新备忘录
     * @param updateMemorandumBo 更新的数据
     * @return 更新是否成功
     */
    Result updateMemorandum(UpdateMemorandumBo updateMemorandumBo);
}

