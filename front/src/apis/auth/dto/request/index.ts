// description: 로그인 Requset Body DTO
export interface SignInRequsetDto {
  userId : string;
  userPassword : string;
}

// description: 아이디 중복 확인 Requset Body DTO
export interface IdCheckRequsetDto {
  userId : string;
}

// description: 이메일 인증 Requset Body DTO
export interface EmailAuthRequsetDto {
  userEmail : string;
}

// description: 이메일 인증 확인 Requset Body DTO
export interface EmailAuthCheckRequsetDto {
  userEmail : string;
  authNumber : string;
}

// description: 회원가입 Requset Body DTO
export interface SignUpRequsetDto {
  userId : string;
  userPassword : string;
  userEmail : string;
  authNumber : string;
}