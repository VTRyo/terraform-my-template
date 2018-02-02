# my Terraform sample

# ディレクトリ構成
## provider

クラウドリソース名でディレクトリを作成しています。

## env

環境名でディレクトリを作成しています。<br>

* common

VPC, SecurityGroup, S3など環境に依存しないリソースであればここに記述する。

* prd

prd環境固有のリソースであればここに記述する。<br>
（例) EC2

# How To Use

## DryRun

`terraform plan`を実行すると、`Enter a value`と表示されます。<br>
ここには実行する環境を入力してください。

(例) prd環境で実行する　→　`Enter a value: prd`

```
$ cd <実行環境ディレクトリ>
$ terraform plan
var.env
  Enter a value: <実行環境>

```

## LiveRun

`terraform apply`を実行すると、`Enter a value`と表示されます。<br>
ここには実行する環境を入力してください。

(例) prd環境で実行する　→　`Enter a value: prd`

```
$ cd <実行環境ディレクトリ>
$ terraform apply
var.env
  Enter a value: <実行環境>
```

## リソースを追加する場合

(例) API用のEC2インスタンスを作成する

１．variable.tfに変数を追加する<br>
２．ec2.tfにリソースの定義を追加する

### prd

１．variable.tfを作成する

追加するリソースの変数ファイルを作成します。<br>

下記のコードはec2.variable.tf内ですでに使用しているものです。<br>
このコードは[map型](https://qiita.com/VTRyo/items/a633eaa3d9049cad0ed5)という型で書いており、`ec2_my_config`という名前の変数の中にkey,value式で値を格納しています。<br>リソース追加には、このコードを流用します。

```
variable "env" { }

variable "ec2_my_config" {
  default = {
    ami                             = "ami-4af5022c"
    instance_type                   = "t2.micro"
    instance_key                    = "infra"
    disable_api_termination         = true
    root_block_device_volume_type   = "gp2"
    root_block_device_volume_size   = "30"
  }
}
```

API用の変数を作成していきます。<br>
変更箇所は以下の通りです。

* `ec2_my_config` →　`ec2_api_config`

必要であれば`instance_type`や`root_block_device_volume_size`なども変更します。<br>
変更したec2.variable.tfは以下の通りです。
```
variable "env" { }

variable "ec2_my_config" {
  default = {
    ami                             = "ami-4af5022c"
    instance_type                   = "t2.micro"
    instance_key                    = "infra"
    disable_api_termination         = true
    root_block_device_volume_type   = "gp2"
    root_block_device_volume_size   = "30"
  }
}

## API用の変数を追加
variable "ec2_api_config" {
  default = {
    ami                             = "ami-4af5022c"
    instance_type                   = "t2.micro"
    instance_key                    = "infra"
    disable_api_termination         = true
    root_block_device_volume_type   = "gp2"
    root_block_device_volume_size   = "30"
  }
}
```

２．ec2.tfに定義を追加する

下記のコードはec2.tfで使用しているものです。<br>

```
resource "aws_instance" "my-server" {
  ami                      = "${lookup(var.ec2_my_config, "ami")}"
  instance_type            = "${lookup(var.ec2_my_config, "instance_type")}"
  disable_api_termination  = "${lookup(var.ec2_my_config, "disable_api_termination")}"
  key_name                 = "${lookup(var.ec2_my_config, "instance_key")}"
  vpc_security_group_ids   = ["${data.terraform_remote_state.common.security_group_mail}"]
  subnet_id                = "${data.terraform_remote_state.common.subnet_public_a_id}"
  root_block_device        = {
    volume_type            = "${lookup(var.ec2_my_config, "root_block_device_volume_type")}"
    volume_size            = "${lookup(var.ec2_my_config, "root_block_device_volume_size")}"
  }
  tags {
    Name                   = "${var.env}-my-${format("server%02d", count.index + 1)}"
  }
}

resource "aws_eip" "my-server" {
  instance                 = "${aws_instance.my-server.id}"
  vpc                      = true
  tags {
    Name                   = "${var.env}-my-${format("server%02d", count.index + 1)}"
  }
}
```

コピペして、API用のリソースを定義します。
```
resource "aws_instance" "my-api-server" {
  ami                      = "${lookup(var.ec2_api_config, "ami")}"
  instance_type            = "${lookup(var.ec2_api_config, "instance_type")}"
  disable_api_termination  = "${lookup(var.ec2_api_config, "disable_api_termination")}"
  key_name                 = "${lookup(var.ec2_api_config, "instance_key")}"
  vpc_security_group_ids   = ["${data.terraform_remote_state.common.security_group_mail}"]
  subnet_id                = "${data.terraform_remote_state.common.subnet_public_a_id}"
  root_block_device        = {
    volume_type            = "${lookup(var.ec2_api_config, "root_block_device_volume_type")}"
    volume_size            = "${lookup(var.ec2_api_config, "root_block_device_volume_size")}"
  }
  tags {
    Name                   = "${var.env}-my-${format("api-server%02d", count.index + 1)}"
  }
}

resource "aws_eip" "api-server" {
  instance                 = "${aws_instance.my-api-server.id}"
  vpc                      = true
  tags {
    Name                   = "${var.env}-my-${format("api-server%02d", count.index + 1)}"
  }
}

```

編集する箇所は以下の通りです。
* `my-server`　→　`my-api`
* `ec2_my_config` →　`ec2_api_config`
* `"${aws_instance.my-server.id}"`　→　`"${aws_instance.my-api-server.id}"`
* `${var.env}-my-${format("server%02d", count.index + 1)}"`　→　`${var.env}-my-${format("api-server%02d", count.index + 1)}"`

以上
