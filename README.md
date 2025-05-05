<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
</head>
<body>
  <h1>Step 1. Run the Script Below on the Database</h1>
  <div class="step">
    <pre><code>
-- Create Bucket
DECLARE
  l_pre_auth VARCHAR2(1200);
BEGIN
  oci_bucket_api.create_bucket(
    p_credential        => /* web credential created for OCI using APEX */,
    p_compartmentid     => /* oci compartment OCID */,
    p_namespace         => /* oci namespace */,
    p_oci_base          => /* OCI base URL */,
    p_oci_bucket_base   => /* OCI bucket base */,
    p_oci_bucket_expr   => /* bucket expiration e.g. '2200-12-31T20:30:00Z' */,
    p_bucket_name       => /* bucket name */,
    p_pre_auth          => l_pre_auth
  );
END;
/

-- Upload to OCI Bucket
BEGIN
  oci_bucket_api.upload_file(
    p_credential      => /* web credential created for OCI using APEX */,
    p_oci_bucket_base => /* OCI bucket base URL */,
    p_bucket_name     => /* bucket name */,
    p_file_name       => /* file name */,
    p_mime_type       => /* MIME type, e.g. 'application/sql' */,
    p_file            => /* BLOB containing the file */
  );
END;
/
    </code></pre>
  </div>
</body>
</html>
