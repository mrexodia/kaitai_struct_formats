# https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.1
meta:
  id: java_class
  endian: be
  file-extension: class
seq:
  - id: magic
    contents: [0xca, 0xfe, 0xba, 0xbe]
  - id: version_minor
    type: u2
  - id: version_major
    type: u2
  - id: constant_pool_count
    type: u2
  - id: constant_pool
    type: constant_pool_entry
    repeat: expr
    repeat-expr: constant_pool_count - 1
  - id: access_flags
    type: u2
  - id: this_class
    type: u2
  - id: super_class
    type: u2
  - id: interfaces_count
    type: u2
  - id: interfaces
    type: u2
    repeat: expr
    repeat-expr: interfaces_count
  - id: fields_count
    type: u2
  - id: fields
    type: field_info
    repeat: expr
    repeat-expr: fields_count
  - id: methods_count
    type: u2
  - id: methods
    type: method_info
    repeat: expr
    repeat-expr: methods_count
  - id: attributes_count
    type: u2
  - id: attributes
    type: attribute_info
    repeat: expr
    repeat-expr: attributes_count
types:
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4
  constant_pool_entry:
    seq:
      - id: tag
        type: u1
        enum: tag_enum
      - id: class_cp_info
        type: class_cp_info
        if: tag == tag_enum::class_type
      - id: field_ref_cp_info
        type: field_ref_cp_info
        if: tag == tag_enum::field_ref
      - id: method_ref_cp_info
        type: method_ref_cp_info
        if: tag == tag_enum::method_ref
      - id: interface_method_ref_cp_info
        type: interface_method_ref_cp_info
        if: tag == tag_enum::interface_method_ref
      - id: string_cp_info
        type: string_cp_info
        if: tag == tag_enum::string
      - id: integer_cp_info
        type: integer_cp_info
        if: tag == tag_enum::integer
      - id: float_cp_info
        type: float_cp_info
        if: tag == tag_enum::float
      - id: long_cp_info
        type: long_cp_info
        if: tag == tag_enum::long
      - id: double_cp_info
        type: double_cp_info
        if: tag == tag_enum::double
      - id: name_and_type_cp_info
        type: name_and_type_cp_info
        if: tag == tag_enum::name_and_type
      - id: utf8_cp_info
        type: utf8_cp_info
        if: tag == tag_enum::utf8
    enums:
      tag_enum:
        7: class_type
        9: field_ref
        10: method_ref
        11: interface_method_ref
        8: string
        3: integer
        4: float
        5: long
        6: double
        12: name_and_type
        1: utf8
        15: method_handle
        16: method_type
        18: invoke_dynamic
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.1
  class_cp_info:
    seq:
      - id: name_index
        type: u2
    instances:
      name:
        value: _root.constant_pool[name_index - 1]
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.2
  field_ref_cp_info:
    seq:
      - id: class_index
        type: u2
      - id: name_and_type_index
        type: u2
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.2
  method_ref_cp_info:
    seq:
      - id: class_index
        type: u2
      - id: name_and_type_index
        type: u2
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.2
  interface_method_ref_cp_info:
    seq:
      - id: class_index
        type: u2
      - id: name_and_type_index
        type: u2
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.3
  string_cp_info:
    seq:
      - id: string_index
        type: u2
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.4
  integer_cp_info:
    seq:
      - id: value
        type: u4
  float_cp_info:
    seq:
      - id: value
        type: f4
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.5
  long_cp_info:
    seq:
      - id: value
        type: u8
  double_cp_info:
    seq:
      - id: value
        type: f8
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.6
  name_and_type_cp_info:
    seq:
      - id: name_index
        type: u2
      - id: descriptor_index
        type: u2
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.7
  utf8_cp_info:
    seq:
      - id: str_len
        type: u2
      - id: value
        type: str
        size: str_len
        encoding: UTF-8
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.8
  method_handle_cp_info:
    seq:
      - id: reference_kind
        type: u1
        enum: reference_kind_enum
      - id: reference_index
        type: u2
    enums:
      reference_kind_enum:
        1: get_field
        2: get_static
        3: put_field
        4: put_static
        5: invoke_virtual
        6: invoke_static
        7: invoke_special
        8: new_invoke_special
        9: invoke_interface
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.9
  method_type_cp_info:
    seq:
      - id: descriptor_index
        type: u2
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.10
  invoke_dynamic_cp_info:
    seq:
      - id: bootstrap_method_attr_index
        type: u2
      - id: name_and_type_index
        type: u2
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.5
  field_info:
    seq:
      - id: access_flags
        type: u2
      - id: name_index
        type: u2
      - id: descriptor_index
        type: u2
      - id: attributes_count
        type: u2
      - id: attributes
        type: attribute_info
        repeat: expr
        repeat-expr: attributes_count
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.7
  attribute_info:
    seq:
      - id: attribute_name_index
        type: u2
      - id: attribute_length
        type: u4
      - id: info
        size: attribute_length
  # https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.6
  method_info:
    seq:
      - id: access_flags
        type: u2
      - id: name_index
        type: u2
      - id: descriptor_index
        type: u2
      - id: attributes_count
        type: u2
      - id: attributes
        type: attribute_info
        repeat: expr
        repeat-expr: attributes_count
