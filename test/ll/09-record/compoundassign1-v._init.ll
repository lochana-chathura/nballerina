@_Bi04root0 = constant {i32, i32, [2 x i32]} {i32 0, i32 2, [2 x i32] [i32 128, i32 256]}
declare void @_B04rootmain()
define void @_bal_main() {
  call void @_B04rootmain()
  ret void
}
