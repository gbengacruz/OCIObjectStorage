<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Step 1: Run Script on Database</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 2rem;
      line-height: 1.5;
      background: #f9f9f9;
      color: #333;
    }
    h1 {
      font-size: 1.8rem;
      margin-bottom: 1rem;
      color: #005a9c;
    }
    .step {
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 6px;
      padding: 1rem;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    pre {
      background: #272822;
      color: #f8f8f2;
      overflow: auto;
      padding: 1rem;
      border-radius: 4px;
      font-family: Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
      font-size: 0.9rem;
    }
    code { display: block; }
  </style>
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
