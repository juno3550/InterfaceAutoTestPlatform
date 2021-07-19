import pymysql

pymysql.version_info = (1, 4, 13, "final", 0)  # 指定版本。在出现“mysqlclient 1.4.0 or newer is required; you have 0.9.3.”报错时加上此行
pymysql.install_as_MySQLdb()