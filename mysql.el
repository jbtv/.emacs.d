
(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
    (flet ((sql-get-login (&rest what)))
      (sql-product-interactive sql-product)))))

(defun sql-tom-dev ()
  (interactive)
  (sql-connect-preset 'tom-dev))

(defun sql-local ()
  (interactive)
  (sql-connect-preset 'local))


