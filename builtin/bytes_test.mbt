// Copyright 2024 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

test "to_string" {
  let bytes = Bytes::of_string("Hello, World!")
  assert_eq!(bytes.to_unchecked_string(), "Hello, World!")
}

test "of_string" {
  let str = "Hello, World!"
  let bytes = Bytes::of_string(str)
  assert_eq!(bytes.length(), str.length() * 2)
}

test "sub_string" {
  let bytes = Bytes::of_string("Hello, World!")
  assert_eq!(bytes.to_unchecked_string(offset=0, length=5 * 2), "Hello")
  // assert_eq(bytes.sub_string(10, 5 * 2), "World")?
}

test "blit_from_string" {
  let bytes = Bytes::new(10)
  let str = "Hello"
  bytes.blit_from_string(0, str, 0, str.length())
  assert_eq!(bytes.to_unchecked_string(offset=0, length=str.length() * 2), str)
}

test "copy" {
  let bytes = Bytes::of_string("Hello, World!")
  let copy_bytes = bytes.copy()
  assert_eq!(copy_bytes.to_unchecked_string(), bytes.to_unchecked_string())
}

test "set_utf16_char" {
  let bytes = Bytes::new(10)
  let char = 'A'
  let len = bytes.set_utf16_char(0, char)
  assert_eq!(len, 2)
  assert_eq!(bytes.to_unchecked_string(offset=0, length=2), "A")
}

test "op_equal" {
  let bytes = Bytes::of_string("Hello, World!")
  let copy_bytes = bytes.copy()
  assert_eq!(bytes, copy_bytes)
  assert_not_eq!(bytes, Bytes::new(10))
}

test "fixedarray_byte_blit_from_string" {
  let arr : FixedArray[Byte] = FixedArray::make(10, Byte::default())
  let str = "Hello"
  arr.blit_from_string(0, str, 0, str.length())
  inspect!(
    arr,
    content="[b'\\x48', b'\\x00', b'\\x65', b'\\x00', b'\\x6C', b'\\x00', b'\\x6C', b'\\x00', b'\\x6F', b'\\x00']",
  )
}

test "fixedarray_byte_blit_from_bytes" {
  let arr : FixedArray[Byte] = FixedArray::make(5, Byte::default())
  let bytes = b"Hello"
  arr.blit_from_bytes(0, bytes, 0, bytes.length())
  inspect!(arr, content="[b'\\x48', b'\\x65', b'\\x6C', b'\\x6C', b'\\x6F']")
}
