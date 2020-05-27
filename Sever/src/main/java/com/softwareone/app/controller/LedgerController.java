package com.softwareone.app.controller;

import com.softwareone.app.bo.UpdateLedgerBo;
import com.softwareone.app.entity.Ledger;
import com.softwareone.app.service.LedgerService;
import com.softwareone.app.vo.PageLimit;
import com.softwareone.app.vo.Result;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

/**
 * @author chenqiting
 */
@RestController
@Validated
public class LedgerController {
    @Resource
    private LedgerService ledgerService;

    @PostMapping("/api/ledger/save")
    public Result saveLedger(@RequestBody @Valid Ledger ledger, UsernamePasswordAuthenticationToken token) {
        ledger.setUserId((Integer) token.getPrincipal());
        return ledgerService.saveLedger(ledger);
    }

    @GetMapping("/api/ledger/get")
    public Result getLedger(@RequestParam("page") @Valid @Min(value = 1, message = "不能小于1") int page,
                            @RequestParam("size") @Valid @Min(1) int size,
                            @RequestParam(value = "year", required = false) @Valid @Min(0) Integer year,
                            @RequestParam(value = "month", required = false) @Valid @Min(1) @Max(12) Integer month,
                            @RequestParam(value = "day", required = false) @Valid @Min(1) @Max(31) Integer day,
                            @RequestParam(value = "type", required = false) @Valid @Min(1) @Max(4) Integer type,
                            UsernamePasswordAuthenticationToken token) {
        return ledgerService.getLedgerByPageAndTime(new PageLimit(page, size), year, month, day, type, (Integer) token.getPrincipal());
    }

    @GetMapping("/api/ledger/sum")
    public Result sumLedgerOnTimeOrAll(UsernamePasswordAuthenticationToken token,
                                       @RequestParam(value = "year", required = false) @Valid @Min(0) Integer year,
                                       @RequestParam(value = "month", required = false) @Valid @Min(1) @Max(12) Integer month,
                                       @RequestParam(value = "day", required = false) @Valid @Min(1) @Max(31) Integer day,
                                       @RequestParam(value = "type", required = false) @Valid @Min(1) @Max(4) Integer type) {
        return ledgerService.sumLedgerOnTimeOrAll((Integer) token.getPrincipal(), year, month, day, type);
    }

    @PostMapping("/api/ledger/delete/{id}")
    public Result deleteLedger(@PathVariable("id") Integer id, UsernamePasswordAuthenticationToken token) {
        return ledgerService.deleteLedger(id, (Integer) token.getPrincipal());
    }

    @PostMapping("/api/ledger/update")
    public Result updateLedger(@RequestBody @Valid UpdateLedgerBo updateLedgerBo, UsernamePasswordAuthenticationToken token) {
        return ledgerService.updateLedger(updateLedgerBo, (Integer) token.getPrincipal());
    }
}
