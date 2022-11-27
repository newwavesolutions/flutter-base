enum ValidatorError {
  notEmpty,
  minValidate,
  maxValidate,
  invalid,
}

enum PasswordValidatorError {
  notEmpty,
  minValidate,
  maxValidate,
  passwordInvalid,
  conformPasswordNotSame,
}

class Validator {
  String? data;
  Validator(this.data);
}

class NameValidator extends Validator {
  NameValidator(super.data);

  ValidatorError? perform({bool isCheckRequire = true}) {
    final name = data ?? "";

    if (isCheckRequire) {
      if (data == null || data!.trim().isEmpty) {
        return ValidatorError.notEmpty;
      }
    }

    if (name.length < 4) {
      return ValidatorError.minValidate;
    } else if (name.length > 20) {
      return ValidatorError.maxValidate;
    }

    return null;
  }
}

class EmailValidator extends Validator {
  static RegExp emailRegex =
      RegExp(r"^[\w]+(\.[\w]+)*@[a-zA-Z]+(\.[a-zA-Z]+)+$");

  EmailValidator(super.data);

  ValidatorError? perform({bool isCheckRequire = true}) {
    if (isCheckRequire) {
      if (data == null || data!.trim().isEmpty) {
        return ValidatorError.notEmpty;
      }
    }

    final isMatch = emailRegex.hasMatch(data ?? "");
    if (isMatch) {
      return null;
    }
    return ValidatorError.invalid;
  }
}

class PasswordValidator extends Validator {
  static RegExp passwordRegex = RegExp('(?=.*[0-9])(?=.*[a-zA-Z]).*');
  PasswordValidator(super.data);

  PasswordValidatorError? perform({bool isCheckRequire = true}) {
    final password = data ?? "";

    if (isCheckRequire) {
      if (password.trim().isEmpty) {
        return PasswordValidatorError.notEmpty;
      }
    }
    if (password.length < 4) {
      return PasswordValidatorError.minValidate;
    } else if (password.length > 20) {
      return PasswordValidatorError.maxValidate;
    }

    final isMatch = passwordRegex.hasMatch(password);

    if (isMatch) {
      return null;
    }
    return PasswordValidatorError.passwordInvalid;
  }
}

class PhoneValidator extends Validator {
  static RegExp phoneRegex = RegExp(r"^(?:[+0]9)?[0-9]{10}$");

  PhoneValidator(super.data);

  ValidatorError? perform({bool isCheckRequire = true}) {
    if (isCheckRequire) {
      if (data == null || data!.trim().isEmpty) {
        return ValidatorError.notEmpty;
      }
    }
    final isValid = phoneRegex.hasMatch(data ?? "");

    if (!isValid) {
      return ValidatorError.invalid;
    }
    return null;
  }
}
