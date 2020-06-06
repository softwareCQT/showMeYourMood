package com.softwareone.app.controller;

import com.softwareone.app.bo.SaveMemorandumBo;
import com.softwareone.app.bo.UpdateMemorandumBo;
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
import java.util.Map;

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
    public Result deleteMemorandumById(@PathVariable("id") int id, UsernamePasswordAuthenticationToken token) {
        return memorandumService.deleteMemorandumById(id, (Integer) token.getPrincipal());
    }

    @PostMapping("/api/memorandum/save")
    public Result saveMemorandum(@RequestBody @Valid SaveMemorandumBo saveMemorandumBo, UsernamePasswordAuthenticationToken token) {
        return memorandumService.saveMemorandum(saveMemorandumBo, (Integer) token.getPrincipal());
    }

    @PostMapping("/api/memorandum/deleteBatch")
    public Result deleteBatchMemorandum(@RequestBody @Valid @NotEmpty Map<String, Object> map, UsernamePasswordAuthenticationToken token) {
        return memorandumService.deleteBatchMemorandum((List<Integer>) map.get("idList"), (Integer) token.getPrincipal());
    }

    @PostMapping("/api/memorandum/update")
    public Result updateMemorandum(@RequestBody @Valid UpdateMemorandumBo updateMemorandumBo) {
        return memorandumService.updateMemorandum(updateMemorandumBo);
    }
}
