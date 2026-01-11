pcDefinePCell(
    list(ddGetObj("PDK_OTFT_4INT") "ptft" "layout")
    (
        (fingers int 1)
        (l float 10.0)
        (w float 100.0)
        (lov float 6.0)           
    )
    let(
        (
            techFile
            lppMC lppM1 lppM2
            gatePitch gateW gateL sdExt
            totalW
            i y0
        )

        ;; ---------- 基本防御 ----------
        fingers = max(1 fingers)

        ;; ---------- 取 tech ----------
        techFile = pcCellView~>techFile

        lppMC = techGetLP(techFile "MC" "drawing")
        lppM1 = techGetLP(techFile "M1" "drawing")
        lppM2 = techGetLP(techFile "M2" "drawing")

        ;; ---------- 几何参数 ----------
        gateL    = l
        gateW    = w
        sdExt    = 6.0          ;; S/D 外延
        gatePitch = gateL + 9.0 ;; finger 间距（可参数化）

        totalW = gateW * fingers

        ;; ======================================================
        ;; 1. Source / Drain（共享，一整条）
        ;; ======================================================
        dbCreateRect(
            pcCellView
            lppM1
            list(
                list(-sdExt -sdExt)
                list(totalW + sdExt gateL + sdExt)
            )
        )

        ;; ======================================================
        ;; 2. Gate（每个 finger 一条）
        ;; ======================================================
        for(i 0 (fingers - 1)
            y0 = i * gatePitch
            dbCreateRect(
                pcCellView
                lppMC
                list(
                    list(i * gateW  y0)
                    list((i+1) * gateW  y0 + gateL)
                )
            )
        )

        ;; ======================================================
        ;; 3. 上层金属（可选，覆盖 Gate）
        ;; ======================================================
        dbCreateRect(
            pcCellView
            lppM2
            list(
                list(0 -sdExt)
                list(totalW gateL + sdExt)
            )
        )

        ;; ---------- PCell 属性 ----------
        dbReplaceProp(pcCellView "function" "string" "transistor")
        dbReplaceProp(pcCellView "viewSubType" "string" "maskLayoutParamCell")

        t
    )
)
