CREATE TABLE `g_car` (
    `G_CAR_ID` INT NOT NULL AUTO_INCREMENT,
    `G_CAR_U_NAME` VARCHAR(255) NOT NULL,
    `G_CAR_G_ID` INT NOT NULL,
    `G_CAR_G_NAME` VARCHAR(255) NOT NULL,
    `G_CAR_PRICE` DOUBLE NOT NULL,
    `G_CAR_NUMBER` INT NOT NULL,
    `G_CAR_G_MADE` VARCHAR(255) NOT NULL,
    `G_CAR_CREATE_DATE` DATE NOT NULL,
    PRIMARY KEY (`G_CAR_ID`)
);

CREATE TABLE `g_order` (
    `G_ORDER_ID` INT NOT NULL AUTO_INCREMENT,
    `G_ORDER_U_NAME` VARCHAR(255) NOT NULL,
    `G_ORDER_G_ID` INT NOT NULL,
    `G_ORDER_PRICE` DOUBLE NOT NULL,
    `G_ORDER_NUMBER` INT NOT NULL,
    `G_ORDER_CREATE_DATE` DATE NOT NULL,
    `G_ORDER_RECEIVER` VARCHAR(255) NOT NULL,
    `G_ORDER_PHONE` VARCHAR(255) NOT NULL,
    `G_ORDER_ADDRESS` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`G_ORDER_ID`)
);

CREATE TABLE `goods` (
  `G_ID` INT NOT NULL AUTO_INCREMENT,
  `G_NAME` VARCHAR(255) NOT NULL,
  `G_DESCRIBE` VARCHAR(255) NOT NULL,
  `G_PRICE` DOUBLE NOT NULL,
  `G_MADE` VARCHAR(255) NOT NULL,
  `G_AMOUNT` INT NOT NULL,
  `G_CREATE_DATE` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `G_PIC` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`G_ID`)
);

CREATE TABLE `user` (
    `U_NAME` VARCHAR(255) NOT NULL,
    `U_ID` INT NOT NULL AUTO_INCREMENT,
    `U_NICK_NAME` VARCHAR(255) NOT NULL,
    `U_SEX` INT NOT NULL,
    `U_PASSWORD` VARCHAR(255) NOT NULL,
    `U_EMAIL` VARCHAR(255) NOT NULL,
    `U_STATE` INT NOT NULL,
    `U_IS_SELLER` INT NOT NULL,
    `U_LAST_LOGIN_TIME` DATE NOT NULL,
    `U_CREATE_DATE` DATE NOT NULL,
    PRIMARY KEY (`U_ID`)
);