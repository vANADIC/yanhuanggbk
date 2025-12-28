# yanhuanggbk

基于梦幻泥潭/FluffOS 的过渡版，保持原始 GB 编码模式，方便后续迁移与兼容性验证。

## 内容
- `bin/driver`：预编译 FluffOS 驱动（x86_64，依赖 libevent/libpcre）。
- `bin/config.ini`：运行配置，端口默认为 1234，编码保持 GB。
- `mudlib/`：游戏资源与脚本，原始 GB 编码。
- `Dockerfile`：固定 `linux/amd64` 基础镜像，安装所需运行时并创建兼容链接。
- `run_local.sh`：一键构建并后台启动容器，容器名 `yanhuangGBK`。

## 使用
1) 确保本机 Docker Desktop 支持 amd64（如需，开启 Rosetta 仿真）。  
2) 运行：`./run_local.sh`  
   - 查看日志：`docker logs -f yanhuangGBK`  
   - 进入容器：`docker exec -it yanhuangGBK /bin/bash`  
3) Telnet 连接：`telnet 127.0.0.1 1234`

## 注意
- 这是 GB 编码保持版，不建议直接混用 UTF-8 文件，避免混杂编码引起的显示或运行异常。  
- 若需改端口或路径，同步调整 `bin/config.ini` 和启动脚本端口映射。
