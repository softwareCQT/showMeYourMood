package com.softwareone.app.controller;

import com.softwareone.app.bo.UpdateMemorandumBo;
import com.softwareone.app.entity.Memorandum;
import com.softwareone.app.service.MemorandumService;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import java.util.List;

/**
 * @author chenqiting
 */
@RestController
@Validated
public class MemorandumController {

    @Resource
    private MemorandumService memorandumService;

    @GetMapping("/api/memorandum/get")
    public Result getMemorandum(PageLimit pageLimit, UsernamePasswordAuthenticationToken token) {
        return memorandumService.getMemorandum(pageLimit, (Integer) token.getPrincipal());
    }
    @PostMapping("/api/memorandum/delete/{id}")
    public Result deleteMemorandumById(@PathVariable("id") int id){
        return memorandumService.deleteMemorandumById(id);
    }
    @PostMapping("/api/memorandum/save")
    public Result saveMemorandum(@RequestBody @Valid Memorandum memorandum, UsernamePasswordAuthenticationToken token){

        return memorandumService.saveMemorandum(memorandum, (Integer)token.getPrincipal());
    }

    @PostMapping("/api/memorandum/delete")
    public Result deleteBatchMemorandum(@RequestBody @Valid @NotEmpty List<Integer> idList) {
        return memorandumService.deleteBatchMemorandum(idList);
    }
    @PostMapping("/api/memorandum/update")
    public Result updateMemorandum(@RequestBody @Valid UpdateMemorandumBo updateMemorandumBo) {
        return memorandumService.updateMemorandum(updateMemorandumBo);
    }
}
