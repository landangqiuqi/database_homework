# 使用官方Tomcat镜像作为基础镜像
FROM tomcat:9.0.113-jdk11-temurin-noble

# 设置工作目录
WORKDIR /usr/local/tomcat

# 删除Tomcat默认的ROOT应用
RUN rm -rf webapps/ROOT

# 复制Maven构建的WAR文件到Tomcat的webapps目录
COPY target/database-homework-1.0-SNAPSHOT.war webapps/ROOT.war

# 暴露Tomcat默认端口
EXPOSE 8080

# 设置容器启动时执行的命令
CMD ["catalina.sh", "run"]
