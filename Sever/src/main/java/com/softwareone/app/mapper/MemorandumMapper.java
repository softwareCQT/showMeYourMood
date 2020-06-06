package com.softwareone.app.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.softwareone.app.bo.UpdateMemorandumBo;
import com.softwareone.app.entity.Memorandum;
import com.softwareone.app.vo.PageLimit;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/***
 * @author chenqiting
 */
@Mapper
public interface MemorandumMapper extends BaseMapper<Memorandum> {
    /***
     *选择id进行分页查询备忘录
     * @param pageLimit 分页条件
     * @param userId 用户唯一标识
     * @return
     */
    List<Memorandum> selectByIdAndPage(PageLimit pageLimit, Integer userId);

    /***
     *更新备忘录
     * @param updateMemorandumBo 更新内容
     * @return 更新的条数
     */
    int updateContentById(@Param("updateMemorandumBo") UpdateMemorandumBo updateMemorandumBo);
}