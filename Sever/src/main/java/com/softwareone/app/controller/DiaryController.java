package com.softwareone.app.controller;

import com.softwareone.app.bo.UpdateDiaryBo;
import com.softwareone.app.entity.Diary;
import com.softwareone.app.service.DiaryService;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import java.util.List;

/**
 * @author chenqiting
 */
@RestController
@Validated
public class DiaryController {

    @Resource
    private DiaryService diaryService;

    @PostMapping("/api/diary/save")
    public Result saveDiary(@RequestBody @Valid Diary diary, UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken) {
        return diaryService.saveDiary(diary, (Integer)usernamePasswordAuthenticationToken.getPrincipal());
    }

    @PostMapping("/api/diary/delete/{id}")
    public Result deleteDiary(@PathVariable("id") Integer id) {
        return diaryService.deleteOwnDiary(id);
    }


    @PostMapping("/api/diary/deleteBatch")
    public Result deleteDiaryBatch(@RequestBody @Valid @NotEmpty List<Integer> idList){
        return diaryService.deleteBatchDiary(idList);
    }

    @PostMapping("/api/diary/update")
    public Result updateDiary(@RequestBody @Valid UpdateDiaryBo diary){
        return diaryService.updateDiary(diary);
    }

    @GetMapping("/api/diary/get")
    public Result getDiaryByDate(UsernamePasswordAuthenticationToken token,
                            @RequestParam("page") @Valid @Min(value = 1, message = "不能小于1") int page,
                            @RequestParam("size")  @Valid @Min(1) int size,
                            @RequestParam(value = "year", required = false) @Valid @Min(0) Integer year,
                            @RequestParam(value = "month", required = false)  @Valid @Min(1) @Max(12) Integer month,
                            @RequestParam(value = "day", required = false)  @Valid @Min(1)@Max(31) Integer day){
        return diaryService.getDiaryByDate((Integer)token.getPrincipal(),new PageLimit(page, size), year, month, day);
    }


}
