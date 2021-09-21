variable REGION-ID {
    default = "ap-south-1"
}

variable INSTANCE-TYPE{
    default = "t2.micro"
}

variable AVAIL-ZONE-1 {
    default = "ap-south-1a"
}

variable AMIS{
    type= map
    default = {
       ap-south-1 = "ami-04bde106886a53080"
    }
}