# JSONB Vs Detail Table Benchmark Tests

Benchmark test for PostgreSQL JSONB vs JOIN tables queries.

## Steps to run tests

1. Clone Repo
2. Install dependencies: `bundle install`
3. Create DB: `rake db:create`
4. Run migrations `rake db:migrate`
5. Seed Database: `rake db:seed`. (change the number of reccords to create in `seeds.rb`)
6. After Seeds finished, run tests: `rake benchmark:business_types`

## Resources

- [JSON Indexing: GIN Indexes](https://www.postgresql.org/docs/9.4/datatype-json.html)
- [PostgreSQL JSON Functions and Operators](https://www.postgresql.org/docs/9.5/functions-json.html)
- [Benchmark Documentation (bmbm)](https://ruby-doc.org/stdlib-1.9.3/libdoc/benchmark/rdoc/Benchmark.html#method-c-bmbm)

# Benchmark Results

**JOIN Table:**

```sql
SELECT businesses.*
FROM businesses
JOIN business_types ON businesses.id=business_types.business_id
WHERE business_types.label IN ('Banking', 'Construction')
```

**JSONB Array:**

```sql
SELECT businesses.*
FROM businesses
WHERE business_types_jsonb ?| array['Banking', 'Construction']
```

## No Index

### 1.000 Records:

```
Running 100 times
Rehearsal ----------------------------------------------------------------
JOIN Table                     0.026261   0.007742   0.034003 (  0.050684)
JSONB Array                    0.001486   0.000228   0.001714 (  0.002560)
------------------------------------------------------- total: 0.035717sec

                                   user     system      total        real
JOIN Table                     0.001724   0.000161   0.001885 (  0.003443)
JSONB Array                    0.001783   0.000133   0.001916 (  0.002541)
```

### 10.000 Records:

```
Running 100 times
Rehearsal ----------------------------------------------------------------
JOIN Table                     0.034611   0.007096   0.041707 (  0.078413)
JSONB Array                    0.009134   0.002286   0.011420 (  0.024585)
------------------------------------------------------- total: 0.053127sec

                                   user     system      total        real
JOIN Table                     0.008514   0.000941   0.009455 (  0.022312)
JSONB Array                    0.009013   0.000352   0.009365 (  0.013743)
```

### 100.000 Records:

```
Running 100 times
Rehearsal ----------------------------------------------------------------
JOIN Table                     0.107336   0.016688   0.124024 (  0.358762)
JSONB Array                    0.132320   0.010514   0.142834 (  0.185709)
------------------------------------------------------- total: 0.266858sec

                                   user     system      total        real
JOIN Table                     0.075488   0.004984   0.080472 (  0.264063)
JSONB Array                    0.071727   0.003726   0.075453 (  0.115145)
```

## Indexes added

```
== 20200716191111 AddIndexesToBusiness: migrating =============================
-- add_index(:businesses, :business_types_jsonb, {:using=>:gin})
   -> 2.5009s
-- add_index(:business_types, :label)
   -> 4.7422s
== 20200716191111 AddIndexesToBusiness: migrated (7.2434s) ====================
```

### 1000.000 Records

```
Running 100 times
Rehearsal ----------------------------------------------------------------
JOIN Table                     0.109680   0.024151   0.133831 (  0.331750)
JSONB Array                    0.080488   0.004847   0.085335 (  0.095859)
------------------------------------------------------- total: 0.219166sec

                                   user     system      total        real
JOIN Table                     0.068790   0.004278   0.073068 (  0.222396)
JSONB Array                    0.062777   0.002012   0.064789 (  0.075382)
```

### 2000.000 Records

```
Running 100 times
Rehearsal ----------------------------------------------------------------
JOIN Table                     0.263863   0.056660   0.320523 (  0.933458)
JSONB Array                    0.143147   0.016053   0.159200 (  0.210145)
------------------------------------------------------- total: 0.479723sec

                                                                                                           user     system      total        real
JOIN Table                     0.151307   0.011216   0.162523 (  0.477628)
JSONB Array                    0.142602   0.006131   0.148733 (  0.171440)
```

### 3000.000 Records

```
Running 100 times
Rehearsal ----------------------------------------------------------------
JOIN Table                     0.316682   0.037228   0.353910 (  0.804805)
JSONB Array                    0.245793   0.020465   0.266258 (  0.334555)
------------------------------------------------------- total: 0.620168sec

                                   user     system      total        real
JOIN Table                     0.209184   0.015760   0.224944 (  0.628174)
JSONB Array                    0.202382   0.008231   0.210613 (  0.262707)
```
