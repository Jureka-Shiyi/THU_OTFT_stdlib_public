flowchart TD
    %% 阶段一：前期定义与库开发
    subgraph Library_Prep ["单元库准备阶段"]
        A["设计规格定义<br/>(OTFT电路功能/性能/工艺约束)"] --> B["OTFT单元库开发"]
        B --> B1["OTFT器件特性表征"]
        B1 --> B2["单元库时序/功耗表征<br/>工具: Siliconsmart"]
        B2 --> B3["单元库格式编译<br/>工具: Library Compiler"]
        B3 --> B4["提取单元库LEF文件<br/>工具: Abstract Generator"]
    end

    %% 阶段二：逻辑设计
    subgraph Logic_Design ["逻辑设计阶段"]
        B4 --> C["RTL设计<br/>(Verilog硬件描述语言编写)"]
        C --> D["逻辑综合<br/>(映射至OTFT单元库)<br/>工具: Design Compiler"]
    end

    %% 阶段三：物理实现
    subgraph Physical_Implementation ["后端物理设计阶段"]
        D --> E1["布局规划/Floorplan<br/>工具: Innovus"]
        E1 --> E2["单元布局/Placement<br/>工具: Innovus"]
        E2 --> E3["时钟树综合/CTS<br/>工具: Innovus"]
        E3 --> E4["布线/Routing<br/>工具: Innovus"]
    end

    %% 阶段四：验证与投片
    subgraph Verification ["验证与交付"]
        E4 --> F["物理验证<br/>(DRC/LVS/ERC检查)<br/>工具: Calibre"]
        F --> G["OTFT数字电路流片与测试"]
    end

    %% 自定义样式
    style A fill:#f9f,stroke:#333,stroke-width:2px
    style G fill:#00ff00,stroke:#333,stroke-width:2px