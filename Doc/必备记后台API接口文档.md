#### 声明：请求失败时，code的值都不为200，可直接打印信息给用户观看。如果响应状态码为400，则参数不合法。

[toc]

# 一、登录模块



## [1.1登录](/api/user/login)

**地址：**/api/user/login

**请求方式：**post

**数据格式：**json

**请求参数示例**：

```json
{
	"email": "1179374184@qq.com",
	"password": "778899"
}
```

**返回数据成功示例：**

```json
{
    "code": 200,
    "msg": "ok",
    "data": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJVc2VySWQiOjEsImlzcyI6IkNoZW5RaVRpbmciLCJleHAiOjE1OTA3Mzc0MTV9.V8v8PRxMp1L78sM0goSYOVy4uZByYYnxw3NOMg1PXDBhKVK3P2pEnjxMe7bbwFWN9_XZo45ca0Dlhvegl15IZJI4hcPadP5VzC9_56fPldM6Nt1uK0qaRBpI4xGwKkkPn_ttCmagQLIG_px9j42bq-91az3o5hlkNRevlp_YUvCp1VwXNCMj1CA3Dv-UYfYpovZWtrInPyjsw7azjObj09hTfAqV6_ka2eJCaY3ZR1ls2uIS3hC_G9JsZVxsYtR4LOJn8SfExThsqS9GE95UsNX5SkmIppOk9SjLlbYMbgImne5M5OAESQUWytINQH505giIbf8dPaQc0BcrYOUVdg"
}
```

## [1.2注册](/api/user/register)

**地址：**/api/user/register

**请求方式：**post

**数据格式：**json

**请求参数示例**：

```json
{
	"email": "1179374184@qq.com",
	"password": "778899"
}
```

**返回数据成功示例：**

```json
{
    "code": 200,
    "msg": "ok"
}
```

## [1.3注册发送验证码](/api/user/register/code/send)

**地址：**/api/user/register/code/send

**请求方式：**get

**数据格式：**url追加参数

**请求参数示例**：

```json
/api/user/register/code/send?email=18244958701@139.com
```

**返回数据成功示例：**

```json
{
    "code": 200,
    "msg": "ok"
}
```

## [1.4修改密码发送验证码](/api/user/password/code/send)

**地址：**/api/user/password/code/send

**请求方式：**get

**数据格式：**url追加参数

**请求参数示例**：

```json
/api/user/password/code/send?email=18244958701@139.com
```

**返回数据成功示例：**

```json
{
    "code": 200,
    "msg": "ok"
}
```

## [1.5验证验证码](/api/user/code/valid)

**地址：**/api/user/code/valid

**请求方式：**get

**数据格式：**url追加参数

**请求参数示例**：

```json
/api/user/code/valid?email=18244958701@139.com
```

**返回数据成功示例：**

```json
{
    "code": 200,
    "msg": "ok"
}
```

## [1.6修改密码](/api/user/password/update)

**地址：**/api/user/password/update

**请求方式：**post

**数据格式：**json

**请求参数示例**：

```json
{
	"email":"1179374184@qq.com",
	"password":"778899"
}
```

**返回数据成功示例：**

```json
{
    "code": 200,
    "msg": "ok"
}
```

